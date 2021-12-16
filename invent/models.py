# coding=utf-8
import csv
import os
import datetime
import decimal
from django.db import models
from django import forms
from mis import settings
from django.utils.encoding import force_text
from django.db import transaction
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const

# 关联了以下模型
from basedata.models import Material, Warehouse, Measure, Organization, Project
from selfhelp.models import WorkOrder
from purchase.models import PurchaseOrder, POItem


class Inventory(generic.BO):
    """
    实时库存
    """
    index_weight = 1
    # 所属组织机构
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 仓库
    warehouse = models.ForeignKey(Warehouse, verbose_name=_("warehouse"), on_delete=models.CASCADE)
    # 物料
    material = models.ForeignKey(Material, verbose_name=_("material"), on_delete=models.CASCADE)
    # 计量单位
    measure = models.ForeignKey(Measure, verbose_name=_("measure"), on_delete=models.CASCADE)
    # 数量
    cnt = models.DecimalField(_("count"), max_digits=14, decimal_places=4)
    # 批次号
    batch = models.CharField(_("batch"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 单价
    price = models.DecimalField(_("price"), max_digits=14, decimal_places=4)

    def __unicode__(self):
        des = self.material.spec or ''
        return u'%s %s %s' % (self.material.code, self.material.name, des)

    class Meta:
        verbose_name = _("Inventory")
        verbose_name_plural = _("Inventory")
        ordering = ['material']


class InitialInventory(generic.BO):
    """
    期初库存
    """
    STATUS = (
        ('0', _("NEW")),        # 新建
        ('9', _("EXECUTED"))    # 已执行
    )
    index_weight = 9
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 所属组织
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 标题
    title = models.CharField(_("title"), max_length=const.DB_CHAR_NAME_40)
    user = models.ForeignKey(User, verbose_name=_("user"), blank=True, null=True, on_delete=models.CASCADE)
    # 状态
    status = models.CharField(_("status"), max_length=const.DB_CHAR_CODE_2, default='0', choices=STATUS)
    # 执行时间
    execute_time = models.DateTimeField(_("execute time"), blank=True, null=True)
    # 附件
    attach = models.FileField(_('attach'), blank=True, null=True, upload_to='inventory', help_text=u'参考FD0002模板文档')
    # 金额
    amount = models.DecimalField(_('money of amount'), max_digits=14, decimal_places=4, blank=True, null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        """"""
        super(InitialInventory, self).save(force_insert, force_update, using, update_fields)

        count = InitItem.objects.filter(master=self).count()
        # 如果有附件并且item为零，自动从附件加载明细行
        if self.attach and count == 0:
            path = os.path.join(settings.MEDIA_ROOT, self.attach.name)
            # csv 文件
            reader = csv.reader(open(path, 'r'))
            index = 0
            with transaction.atomic():
                for code, name, description, unit_code, unit_name, warehouse_code, warehouse_name, price, cnt in reader:
                    index += 1
                    if index == 1:
                        continue

                    material = None
                    measure = None
                    house = None

                    try:
                        measure = Measure.objects.get(code=unit_code)
                    except Exception:
                        measure = Measure.objects.create(code=unit_code, name=force_text(unit_name.decode('gbk')))

                    try:
                        house = Warehouse.objects.get(code=warehouse_code)
                    except Exception:
                        house = Warehouse.objects.create(code=warehouse_code, name=force_text(warehouse_name.decode('gbk')))

                    try:
                        material = Material.objects.get(code=code)
                    except Exception:
                        material = Material(
                            code=code, name=force_text(
                                name.decode('gbk')), spec=force_text(
                                description.decode('gbk')), warehouse=house)
                        material.stock_price = price
                        material.save()
                    InitItem.objects.create(master=self, material=material, price=price, cnt=cnt,
                                            warehouse=house, measure=measure, source=self.code)

    def init_entry(self, request=None):
        """
        执行期初入库
        """
        count = InitItem.objects.filter(master=self).count()
        if count > 0:
            with transaction.atomic():
                total_amount = 0
                for item in InitItem.objects.filter(master=self).all():
                    Inventory.objects.create(
                        material=item.material,
                        price=item.price,
                        cnt=item.cnt,
                        warehouse=item.warehouse,
                        measure=item.measure)
                    item.status = 1
                    item.event_time = datetime.datetime.now()
                    item.source = self.code
                    item.save()
                    item.material.stock_price = item.price
                    if item.material.measure.count() == 0:
                        item.material.measure.add(item.measure)
                    item.material.save()
                    total_amount += item.price * item.cnt
                self.amount = total_amount
                self.status = '9'
                self.execute_time = datetime.datetime.now()
                self.save()
        else:
            raise Exception(_("none material was found"))

    class Meta:
        verbose_name = _("Initial Inventory")
        verbose_name_plural = _("Initial Inventory")


class StockIn(generic.BO):
    """
    入库单
    """
    STATUS = (
        ('0', _("NEW")),                # 新建
        ('1', _("QUALITY TESTING")),    # 质量检验
        ('9', _("EXECUTED"))            # 已执行
    )
    index_weight = 3
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 所属组织机构
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 仓库
    warehouse = models.ForeignKey(Warehouse, verbose_name=_("warehouse"), on_delete=models.CASCADE)
    # 标题
    title = models.CharField(_("title"), max_length=const.DB_CHAR_NAME_40)
    # 入库人（？）
    user = models.ForeignKey(User, verbose_name=_("user"), blank=True, null=True, on_delete=models.CASCADE)
    # 状态
    status = models.CharField(_("status"), max_length=const.DB_CHAR_CODE_2, default='0', choices=STATUS)
    # 执行时间
    execute_time = models.DateTimeField(_("execute time"), blank=True, null=True)
    # 关联的采购单
    po = models.ForeignKey(
        PurchaseOrder,
        verbose_name=_("purchase order"),
        null=True,
        limit_choices_to={"entry_status": "0"},
        blank=True,
        on_delete=models.CASCADE)
    # 入库金额
    amount = models.DecimalField(_("stock in money of amount"), max_digits=14, decimal_places=4, blank=True, null=True)
    # 批次号
    batch = models.CharField(_("batch"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)

    def money_of_amount(self):
        if self.amount:
            return self.amount
        else:
            return 0.00

    def entry_time(self):
        """入库时间"""
        if self.execute_time:
            return self.execute_time
        else:
            return ''

    money_of_amount.short_description = _("stock in money of amount")
    entry_time.short_description = _("entry time")

    def action_entry(self, request):
        """
        执行入库操作
        """

        # 入库明细行大于零
        if self.initem_set.count() > 0:
            with transaction.atomic():
                total_amount = decimal.Decimal(0)
                for item in self.initem_set.filter(status=0).all():
                    try:
                        # 根据仓库、物料和单位获取 实时库存 inventory 对象
                        inventory = Inventory.objects.get(
                            warehouse=self.warehouse, material=item.material, measure=item.measure)
                        if inventory.price != item.price:
                            at = decimal.Decimal(inventory.price * inventory.cnt + item.price * item.cnt)
                            ac = decimal.Decimal(inventory.cnt + item.cnt)
                            average = at / ac
                            inventory.price = average
                            item.material.stock_price = average
                            item.material.save()
                        inventory.cnt += item.cnt
                        inventory.save()
                        total_amount += item.price * item.cnt
                    except Exception:
                        Inventory.objects.create(warehouse=self.warehouse, material=item.material, measure=item.measure,
                                                 cnt=item.cnt, price=item.price, org=self.org)
                        item.material.stock_price = item.price
                        item.material.save()

                        item.status = 1
                        item.event_time = datetime.datetime.now()
                        item.source = self.code
                        item.save()
                        total_amount += item.price * item.cnt

                    # 处理采购明细行
                    # saving the purchase item
                    item.po_item.is_in_stock = 1
                    item.po_item.in_stock_time = datetime.datetime.now()  # 入库时间
                    item.po_item.entry_cnt = item.cnt  # 已经入库数量

                    item.po_item.save()
                    none_zero_left = POItem.objects.filter(po=item.po_item.po, left_cnt__gt=0).count()
                    if none_zero_left == 0:
                        # 没有 零剩余 的明细行，则表示全部入库
                        item.po_item.po.status = '99'  # 标记为已经入库
                        item.po_item.po.entry_status = 1  # 已入库
                        item.po_item.po.entry_time = datetime.datetime.now()  # 入库时间
                        item.po_item.po.save()
                    # saving stock in item status
                    item.status = 1
                    item.event_time = datetime.datetime.now()  # 执行时间
                # updating master's record
                self.status = 9
                self.execute_time = datetime.datetime.now()
                self.amount = total_amount
                self.save()

    class Meta:
        verbose_name = _("StockIn")
        verbose_name_plural = _("StockIn")


class StockOut(generic.BO):
    """
    领料单
    """
    STATUS = (
        ('0', _("NEW")),            # 新建
        ('1', _("IN PROGRESS")),    # 在处理
        ('9', _("EXECUTED"))        # 已执行
    )
    index_weight = 2
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 所属组织机构
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 标题
    title = models.CharField(_("title"), max_length=const.DB_CHAR_NAME_40)
    # 关联的项目
    project = models.ForeignKey(Project, verbose_name=_("project"), blank=True, null=True, on_delete=models.CASCADE)
    # 关联的工单
    wo = models.ForeignKey(WorkOrder, verbose_name=_("work order"), blank=True, null=True, on_delete=models.CASCADE)
    # 描述
    description = models.TextField(_("description"), blank=True, null=True)
    # 出库金额
    amount = models.DecimalField(_("money of amount"), max_digits=14, decimal_places=4, blank=True, null=True)
    # 领料人
    user = models.ForeignKey(User, verbose_name=_("out user"), blank=True, null=True, on_delete=models.CASCADE)
    # 状态
    status = models.CharField(_("status"), max_length=const.DB_CHAR_CODE_2, default='0', choices=STATUS)
    # 执行时间
    execute_time = models.DateTimeField(_("execute time"), blank=True, null=True)

    def out_amount(self):
        return self.amount or ''

    def out_time(self):
        return self.execute_time or ''

    out_time.short_description = _('stock out time')
    out_amount.short_description = _('stock out amount')

    def action_out(self, request=None):
        """
        执行出库操作
        """
        if self.outitem_set.count() > 0:
            with transaction.atomic():
                total = decimal.Decimal(0)
                for item in OutItem.objects.filter(master=self).all():
                    if item.inventory.cnt < item.cnt:
                        raise Exception('%s does not meets required' % item.material)
                    if item.cnt:
                        total += item.cnt * item.inventory.price
                        item.inventory.cnt -= item.cnt
                        item.status = 1  # 标记为已执行
                        item.price = item.inventory.price
                        item.event_time = datetime.datetime.now()  # 执行时间
                        item.inventory.save()
                        item.source = self.code
                        item.save()
                if total > 0:
                    self.amount = total
                self.status = '9'
                self.execute_time = datetime.datetime.now()
                self.save()

    class Meta:
        verbose_name = _("StockOut")
        verbose_name_plural = _("StockOut")


class WareReturn(generic.BO):
    """
    返库单
    """
    STATUS = (
        ('0', _("NEW")),            # 新建
        ('1', _("IN PROGRESS")),    # 在处理
        ('9', _("EXECUTED"))        # 已执行
    )
    index_weight = 5
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 所属组织机构
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 标题
    title = models.CharField(_("title"), max_length=const.DB_CHAR_NAME_40)
    # 关联的领料单
    out = models.ForeignKey(StockOut, verbose_name=_('StockOut'), on_delete=models.CASCADE)
    # 金额
    amount = models.DecimalField(_("money of amount"), max_digits=14, decimal_places=4, blank=True, null=True)
    # 操作人（？）
    user = models.ForeignKey(User, verbose_name=_("out user"), blank=True, null=True, on_delete=models.CASCADE)
    # 状态
    status = models.CharField(_("status"), max_length=const.DB_CHAR_CODE_2, default='0', choices=STATUS)
    # 执行时间
    execute_time = models.DateTimeField(_("execute time"), blank=True, null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(WareReturn, self).save(force_insert, force_update, using, update_fields)
        item_count = ReturnItem.objects.filter(master=self).count()
        if self.out and item_count == 0:
            for out_item in OutItem.objects.filter(master=self.out):
                ReturnItem.objects.create(
                    master=self,
                    out_item=out_item,
                    material=out_item.material,
                    price=out_item.price,
                    measure=out_item.measure,
                    warehouse=out_item.warehouse,
                    out_cnt=out_item.cnt,
                    cnt=out_item.cnt)

    def action_return(self, request):
        """执行返库单"""
        with transaction.atomic():
            total_amount = decimal.Decimal(0)
            for item in ReturnItem.objects.filter(master=self):
                if item.cnt > item.out_item.cnt or item.cnt < 0:
                    raise Exception('%s cnt is invalid,out is %s,return is %s' % (item.material, item.out_cnt, item.cnt))
                item.event_time = datetime.datetime.now()
                item.source = self.code
                item.status = 1
                item.out_item.inventory.cnt += item.cnt
                item.out_item.inventory.save()
                item.save()
                total_amount += item.price * item.cnt
            self.amount = total_amount
            self.status = '9'
            self.execute_time = datetime.datetime.now()
            self.save()

    class Meta:
        verbose_name = _("ware return")
        verbose_name_plural = _("ware return")


class WareAdjust(generic.BO):
    """
    库存调整
    """
    STATUS = (
        ('0', _("NEW")),            # 新建
        ('1', _("IN PROGRESS")),    # 在处理
        ('9', _("EXECUTED"))        # 已执行
    )
    index_weight = 4
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 所属组织机构
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 标题
    title = models.CharField(_("title"), max_length=const.DB_CHAR_NAME_40)
    # 描述
    description = models.TextField(_("description"), blank=True, null=True)
    # 操作者？
    user = models.ForeignKey(User, verbose_name=_("out user"), blank=True, null=True, on_delete=models.CASCADE)
    # 状态
    status = models.CharField(_("status"), max_length=const.DB_CHAR_CODE_2, default='0', choices=STATUS)
    # 执行时间
    execute_time = models.DateTimeField(_("execute time"), blank=True, null=True)

    def action_adjust(self, request):
        """执行库存调整"""
        with transaction.atomic():
            for item in AdjustItem.objects.filter(master=self, status=0):
                inventory = item.inventory
                if item.prop == '+':
                    inventory.cnt += item.cnt
                else:
                    inventory.cnt -= item.cnt
                inventory.save()
                item.status = 1
                item.event_time = datetime.datetime.now()
                item.source = self.code
                item.save()
            self.status = '9'
            self.execute_time = datetime.datetime.now()
            self.save()

    class Meta:
        verbose_name = _("ware adjust")
        verbose_name_plural = _("ware adjust")


class InOutDetail(models.Model):
    """出入库详单
    因为需要在实时库存显示某物料的出入库状态，需要查询该表，所以不能设置为抽象类
    """

    PROP = (
        ('+', _("PLUS")),
        ('-', _("MINUS"))
    )

    # 创建时间
    create_time = models.DateTimeField(_("create time"), auto_now_add=True)
    # 是否已经执行？
    status = models.BooleanField(_("executed"), default=0)
    # 事件时间
    event_time = models.DateTimeField(_("event time"), blank=True, null=True)
    # 仓库
    warehouse = models.ForeignKey(Warehouse, verbose_name=_("warehouse"), blank=True, null=True, on_delete=models.CASCADE)
    # 物料
    material = models.ForeignKey(
        Material,
        verbose_name=_("material"),
        limit_choices_to={"is_virtual": "0"},  # 排除了虚拟物料
        blank=True,
        null=True,
        on_delete=models.CASCADE)
    # 计量单位
    measure = models.ForeignKey(Measure, verbose_name=_("measure"), blank=True, null=True, on_delete=models.CASCADE)
    # 数量
    cnt = models.DecimalField(_("count"), max_digits=14, decimal_places=4, blank=True, null=True)
    # 批次号
    batch = models.CharField(_("batch"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 金额
    price = models.DecimalField(_("price"), max_digits=14, decimal_places=4, blank=True, null=True)
    # 增减属性
    prop = models.CharField(_("plus or minus property"), max_length=const.DB_CHAR_CODE_2, choices=PROP, default='+')
    # 原始单据：用于存放相关订单编号
    source = models.CharField(_("source"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)


class InitItem(InOutDetail):
    """
    期初入库明细行
    """
    master = models.ForeignKey(InitialInventory, on_delete=models.CASCADE)

    class Meta:
        verbose_name = _("init item")
        verbose_name_plural = _("init item")


class InItem(InOutDetail):
    """
    入库单明细行，继承 InOutDetail 类
    """
    # 关联入库单
    master = models.ForeignKey(StockIn, on_delete=models.CASCADE)
    # 关联采购单明细行
    po_item = models.ForeignKey(POItem, verbose_name=_("po item"), blank=True, null=True, on_delete=models.CASCADE)

    def get_new_price(self):
        if self.po_item and self.master.warehouse:
            try:
                inventory = Inventory.objects.get(warehouse=self.master.warehouse, material=self.material, measure=self.measure)
                if inventory and self.price != inventory.price:
                    total_amount = self.price * self.cnt + inventory.price * inventory.cnt
                    total_count = self.cnt + inventory.cnt
                    return total_amount / total_count
            except Exception as e:
                pass
        return self.price or ''

    class Meta:
        verbose_name = _("in item")
        verbose_name_plural = _("in item")


class InItemForm(forms.ModelForm):

    new_price = forms.CharField(label=_('new price'), required=False)

    class Meta:
        model = InItem
        fields = ('material', 'measure', 'cnt', 'price')


class OutItem(InOutDetail):
    """
    领料单明细行，继承 InOutDetail 类
    """
    # 关联的领料单
    master = models.ForeignKey(StockOut, on_delete=models.CASCADE)
    # 库存物资
    inventory = models.ForeignKey(
        Inventory,
        blank=True,
        null=True,
        verbose_name=_("inventory material"),
        on_delete=models.CASCADE)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        self.prop = '-'
        if self.inventory:
            self.material = self.inventory.material
            self.measure = self.inventory.measure
            self.warehouse = self.inventory.warehouse

        super(OutItem, self).save(force_insert, force_update, using, update_fields)

    class Meta:
        verbose_name = _("out item")
        verbose_name_plural = _("out item")


class ReturnItem(InOutDetail):
    """
    返库单明细行，继承 InOutDetail 类
    """
    # 关联的返库单
    master = models.ForeignKey(WareReturn, on_delete=models.CASCADE)
    # 关联的领料单明细行
    out_item = models.ForeignKey(OutItem, blank=True, null=True, verbose_name=_('out item'), on_delete=models.CASCADE)
    out_cnt = models.DecimalField(_("out count"), max_digits=14, decimal_places=4)

    class Meta:
        verbose_name = _("return item")
        verbose_name_plural = _("return item")


class AdjustItem(InOutDetail):
    """
    库存调整明细行
    """
    # 关联库存调整单
    master = models.ForeignKey(WareAdjust, on_delete=models.CASCADE)
    # 实时库存
    inventory = models.ForeignKey(
        Inventory,
        blank=True,
        null=True,
        verbose_name=_("inventory material"),
        on_delete=models.CASCADE)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.inventory:
            self.material = self.inventory.material
            self.measure = self.inventory.measure
            self.warehouse = self.inventory.warehouse
        super(AdjustItem, self).save(force_insert, force_update, using, update_fields)

    class Meta:
        verbose_name = _("adjust item")
        verbose_name_plural = _("adjust item")
