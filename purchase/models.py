# coding=utf-8
import datetime
import os
import xlrd
import decimal
from django.db import transaction
from django.db import models
from django.db.models.aggregates import Sum
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.utils.encoding import force_text
from mis import settings
from common import generic
from common import const
from selfhelp.models import WOItem
from basedata.models import Material, Organization, Partner, Measure, BankAccount


class PurchaseOrder(generic.BO):
    """
    采购单
    """
    STATUS = (
        ('0', _("NEW")),                # 新建
        ('1', _("IN PROGRESS")),        # 在处理
        ('4', _("DROP")),               # 废弃
        ('9', _("APPROVED")),           # 批准
        ('99', _("ALREADY STOCK IN")),  # 已入库
    )
    index_weight = 1
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 合作伙伴
    partner = models.ForeignKey(
        Partner,
        verbose_name=_("partner"),
        limit_choices_to={
            "partner_type": "S"},
        on_delete=models.CASCADE)
    # 订单日期
    order_date = models.DateField(_("order date"))
    # 交货日期
    arrive_date = models.DateField(_("arrive date"))
    # 所属组织
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    # 标题
    title = models.CharField(_("title"), max_length=const.DB_CHAR_NAME_40)
    # 描述信息
    description = models.TextField(_("description"), blank=True, null=True)
    # 创建者（？）
    user = models.ForeignKey(User, verbose_name=_("user"), blank=True, null=True, on_delete=models.CASCADE)
    # 状态
    status = models.CharField(_("status"), max_length=const.DB_CHAR_CODE_2, default='0', choices=STATUS)
    # 金额
    amount = models.DecimalField(_("money amount"), max_digits=12, decimal_places=2, blank=True, null=True, default=0.00)
    # 折扣
    discount_amount = models.DecimalField(
        _("discount amount"),
        max_digits=12,
        decimal_places=2,
        blank=True,
        null=True,
        default=0.00)
    entry_status = models.BooleanField(_("entry status"), default=0)
    entry_time = models.DateTimeField(_("entry time"), blank=True, null=True)
    # 附件
    attach = models.FileField(_('attach'), blank=True, null=True, help_text=u'您可导入采购明细，模板请参考文档FD0008')

    def __unicode__(self):
        return u'%s %s' % (self.code, self.title)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(PurchaseOrder, self).save(force_insert, force_update, using, update_fields)
        # 如果折扣金额大于0
        if self.discount_amount > 0:
            sql = 'UPDATE purchase_poitem a SET a.discount_price = ' \
                  'a.price-((SELECT discount_amount/amount FROM purchase_purchaseorder WHERE id=%s)*a.amount/a.cnt) WHERE a.po_id = %s'
            params = [self.id, self.id]
            generic.update(sql, params)

        # 采购单明细行数量
        item_count = POItem.objects.filter(po=self).count()
        # 如果有附件并且明细行数量为零，则从附件导入明细行
        if self.attach and item_count == 0:
            path = os.path.join(settings.MEDIA_ROOT, self.attach.name)
            workbook = xlrd.open_workbook(path)
            sheet = workbook.sheet_by_index(0)
            row_count = sheet.nrows
            with transaction.atomic():
                total_amount = decimal.Decimal(0)
                for row_index in range(row_count):
                    row = sheet.row_values(row_index)
                    if row_index == 0:
                        doc_type = row[1]
                        if doc_type.startswith('0'):
                            break
                        else:
                            continue
                    elif row_index < 3:
                        continue

                    material = None
                    measure = None

                    try:
                        measure = Measure.objects.get(code=row[4])
                    except Exception:
                        measure = Measure.objects.create(code=row[4], name=force_text(row[5]))

                    try:
                        material = Material.objects.get(code=row[0])
                    except Exception:
                        material = Material(code=row[0], name=force_text(row[1]), spec=force_text(row[2]))
                        material.purchase_price = row[6]
                        material.save()
                    amount = decimal.Decimal(row[6]) * decimal.Decimal(row[7])
                    POItem.objects.create(po=self, material=material, measure=measure, cnt=row[7], price=row[6], amount=amount)
                    total_amount += amount
                # 更新采购金额
                sql = 'update purchase_purchaseorder set amount = %s where id=%s'
                params = [total_amount, self.id]
                generic.update(sql, params)

    def invoice_amount(self):
        total = Invoice.objects.filter(po=self).aggregate(Sum('vo_amount')).get('vo_amount__sum') or 0.00
        return total

    def payed_amount(self):
        return Payment.objects.filter(po=self).aggregate(Sum('py_amount')).get('py_amount__sum') or 0.00

    invoice_amount.short_description = _('invoice amount')
    payed_amount.short_description = _('pay amount')

    class Meta:
        verbose_name = _("purchase order")
        verbose_name_plural = _("purchase orders")


class POItem(models.Model):
    """
    采购单明细行
    """
    index_weight = 2
    # 关联的采购单
    po = models.ForeignKey(PurchaseOrder, verbose_name=_("purchase order"), on_delete=models.CASCADE)
    # 关联的物料
    material = models.ForeignKey(
        Material,
        verbose_name=_("material"),
        limit_choices_to={
            "is_virtual": "0"},
        on_delete=models.CASCADE)
    # 计量单位
    measure = models.ForeignKey(Measure, verbose_name=_("measure"), blank=True, null=True, on_delete=models.CASCADE)
    # 单价
    price = models.DecimalField(_("price"), max_digits=12, decimal_places=4, blank=True, null=True)
    # 数量
    cnt = models.DecimalField(_("count"), max_digits=12, decimal_places=4, blank=True, null=True)
    # 折后单价
    discount_price = models.DecimalField(_("discount price"), max_digits=12, decimal_places=4, blank=True, null=True)
    amount = models.DecimalField(_("money of amount"), max_digits=12, decimal_places=2, blank=True, null=True)
    discount_amount = models.DecimalField(_("discount amount"), max_digits=12, decimal_places=2, blank=True, null=True)
    # 税率
    tax = models.CharField(_("tax rate"), max_length=const.DB_CHAR_CODE_6, choices=const.get_value_list('S052'), default='0.00')
    woitem = models.ForeignKey(WOItem, verbose_name=_("wo item"), blank=True, null=True, on_delete=models.CASCADE)
    # 已经入库
    is_in_stock = models.BooleanField(_("is in stock"), default=0)
    # 入库时间
    in_stock_time = models.DateTimeField(_("execute time"), blank=True, null=True)
    entry_cnt = models.DecimalField(_("entry count"), max_digits=12, decimal_places=4, blank=True, null=True)
    left_cnt = models.DecimalField(_("left count"), max_digits=12, decimal_places=4, blank=True, null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        # 计算总价
        if self.price and self.cnt:
            money = self.price * self.cnt
            self.amount = money

        # 自动配置计量单位
        if self.measure is None and self.material and self.material.measure.count() > 0:
            self.measure = self.material.measure.all()[0]

        if self.is_in_stock:
            self.left_cnt -= self.entry_cnt
        else:
            self.left_cnt = self.cnt
        super(POItem, self).save(force_insert, force_update, using, update_fields)
        # 把价格配给物料数据模型的采购价格
        self.material.purchase_price = self.price
        self.material.save()

        # 自动更新采购单的总价
        sql = 'UPDATE purchase_purchaseorder SET amount = (SELECT SUM(a.price*a.cnt) AS amount FROM ' \
            'purchase_poitem a WHERE a.po_id = %s) WHERE id = %s'
        params = [self.po.id, self.po.id]
        generic.update(sql, params)

    def vender(self):
        """卖家"""
        return u'%s' % (self.po.partner)

    vender.short_description = _("partner")

    class Meta:
        verbose_name = _("po item")
        verbose_name_plural = _("po item")


class Invoice(generic.BO):
    """
    采购发票
    """
    index_weight = 4
    vo_date = models.DateField(_("invoice date"), blank=True, null=True, default=datetime.date.today)
    code = models.CharField(_("invoice code"), max_length=const.DB_CHAR_NAME_20)
    number = models.CharField(_("invoice number"), max_length=const.DB_CHAR_NAME_20)
    po = models.ForeignKey(PurchaseOrder, verbose_name=_("purchase order"), on_delete=models.CASCADE)
    partner = models.ForeignKey(Partner, verbose_name=_("partner"), blank=True, null=True, on_delete=models.CASCADE)
    po_amount = models.DecimalField(_("po amount"), max_digits=14, decimal_places=4, blank=True, null=True)
    vo_amount = models.DecimalField(_("invoice amount"), max_digits=14, decimal_places=4)
    file = models.FileField(_("invoice file"), upload_to='invoice', blank=True, null=True)

    def __unicode__(self):
        return u"%s %s" % (self.code, self.partner)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.po:
            self.partner = self.po.partner
            self.po_amount = self.po.amount
        super(Invoice, self).save(force_insert, force_update, using, update_fields)

    class Meta:
        verbose_name = _("Invoice")
        verbose_name_plural = _("Invoice")


class Payment(generic.BO):
    """
    采购付款
    """
    index_weight = 3
    py_date = models.DateField(_("pay date"), blank=True, null=True, default=datetime.date.today)
    org = models.ForeignKey(Organization, verbose_name=_("organization"), blank=True, null=True, on_delete=models.CASCADE)
    code = models.CharField(_("pay code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    po = models.ForeignKey(PurchaseOrder, verbose_name=_("purchase order"), on_delete=models.CASCADE)
    partner = models.ForeignKey(Partner, verbose_name=_("partner"), blank=True, null=True, on_delete=models.CASCADE)
    po_amount = models.DecimalField(_("po amount"), max_digits=14, decimal_places=4, blank=True, null=True)
    py_amount = models.DecimalField(_("pay amount"), max_digits=14, decimal_places=4)
    bank = models.ForeignKey(BankAccount, verbose_name=_("bank account"), blank=True, null=True, on_delete=models.CASCADE)
    response_code = models.CharField(_("response code"), max_length=const.DB_CHAR_NAME_80, blank=True, null=True)
    memo = models.TextField(_("memo"), blank=True, null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.po:
            self.partner = self.po.partner
            self.po_amount = self.po.amount
        super(Payment, self).save(force_insert, force_update, using, update_fields)

    def __unicode__(self):
        return u"%s %s" % (self.code, self.partner)

    class Meta:
        verbose_name = _("Payment")
        verbose_name_plural = _("Payment")
