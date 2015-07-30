# coding=utf-8
import csv
import os
import datetime
import decimal
from django.db import transaction
from django.db import models
from django import forms
from mis import settings
from django.utils.text import force_text
from django.db import transaction
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const
from basedata.models import Material,Warehouse,Measure,Organization,Project
from selfhelp.models import WorkOrder
from purchase.models import PurchaseOrder,POItem


class Inventory(generic.BO):
    """
    库存信息
    """
    index_weight = 1
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    warehouse = models.ForeignKey(Warehouse,verbose_name=_("warehouse"))
    material = models.ForeignKey(Material,verbose_name=_("material"))
    measure = models.ForeignKey(Measure,verbose_name=_("measure"))
    cnt = models.DecimalField(_("count"),max_digits=14,decimal_places=4)
    batch = models.CharField(_("batch"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    price = models.DecimalField(_("price"),max_digits=14,decimal_places=4)

    def __unicode__(self):
        des = self.material.spec or ''
        return u'%s %s %s' % (self.material.code,self.material.name,des)

    class Meta:
        verbose_name = _("Inventory")
        verbose_name_plural = _("Inventory")
        ordering = ['material']


class InitialInventory(generic.BO):
    """
    期初库存
    """
    STATUS = (
        ('0', _("NEW")),
        ('9', _("EXECUTED"))
    )
    index_weight = 9
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    execute_time = models.DateTimeField(_("execute time"),blank=True,null=True)
    attach = models.FileField(_('attach'),blank=True,null=True,upload_to='inventory',help_text=u'参考FD0002模板文档')
    amount = models.DecimalField(_('money of amount'),max_digits=14,decimal_places=4,blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):

        super(InitialInventory,self).save(force_insert,force_update,using,update_fields)
        count = InitItem.objects.filter(master=self).count()
        if self.attach and count == 0:
            path = os.path.join(settings.MEDIA_ROOT,self.attach.name)
            reader = csv.reader(open(path,'r'))
            index = 0
            with transaction.atomic():
                for code,name,description,unit_code,unit_name,warehouse_code,warehouse_name,price,cnt in reader:
                    index+=1
                    if index == 1:
                        continue

                    material = None
                    measure = None
                    house = None

                    try:
                        measure = Measure.objects.get(code=unit_code)
                    except Exception,e:
                        measure = Measure.objects.create(code=unit_code,name=force_text(unit_name.decode('gbk')))

                    try:
                        house = Warehouse.objects.get(code=warehouse_code)
                    except Exception,e:
                        house = Warehouse.objects.create(code=warehouse_code,name=force_text(warehouse_name.decode('gbk')))

                    try:
                        material = Material.objects.get(code=code)
                    except Exception,e:
                        material = Material(code=code,name=force_text(name.decode('gbk')),spec=force_text(description.decode('gbk')),warehouse=house)
                        material.stock_price = price
                        material.save()
                    InitItem.objects.create(master=self,material=material,price=price,cnt=cnt,warehouse=house,measure=measure,source=self.code)

    def init_entry(self,request=None):
        """
        执行期初入库
        """
        count = InitItem.objects.filter(master=self).count()
        if count > 0:
            with transaction.atomic():
                total_amount = 0
                for item in InitItem.objects.filter(master=self).all():
                    Inventory.objects.create(material=item.material,price=item.price,cnt=item.cnt,warehouse=item.warehouse,measure=item.measure)
                    item.status = 1
                    item.event_time = datetime.datetime.now()
                    item.source = self.code
                    item.save()
                    item.material.stock_price = item.price
                    if item.material.measure.count() == 0:
                        item.material.measure.add(item.measure)
                    item.material.save()
                    total_amount += item.price*item.cnt
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
        ('0', _("NEW")),
        ('1', _("QUALITY TESTING")),
        ('9', _("EXECUTED"))
    )
    index_weight = 3
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    warehouse = models.ForeignKey(Warehouse,verbose_name=_("warehouse"))
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    execute_time = models.DateTimeField(_("execute time"),blank=True,null=True)
    po = models.ForeignKey(PurchaseOrder,verbose_name=_("purchase order"),null=True,limit_choices_to={"entry_status":"0"},blank=True)
    amount = models.DecimalField(_("stock in money of amount"),max_digits=14,decimal_places=4,blank=True,null=True)
    batch = models.CharField(_("batch"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)

    def money_of_amount(self):
        if self.amount:
            return self.amount
        else:
            return 0.00

    def entry_time(self):
        if self.execute_time:
            return self.execute_time
        else:
            return ''

    money_of_amount.short_description = _("stock in money of amount")
    entry_time.short_description = _("entry time")

    def action_entry(self,request):
        """
        执行入库操作
        """
        if self.initem_set.count() > 0:
            with transaction.atomic():
                total_amount = decimal.Decimal(0)
                for item in self.initem_set.filter(status=0).all():
                    try:
                        inventory = Inventory.objects.get(warehouse=self.warehouse,material=item.material,measure=item.measure)
                        if inventory.price != item.price:
                            at = decimal.Decimal(inventory.price*inventory.cnt+item.price*item.cnt)
                            ac = decimal.Decimal(inventory.cnt+item.cnt)
                            average = at/ac
                            inventory.price = average
                            item.material.stock_price = average
                            item.material.save()
                        inventory.cnt += item.cnt
                        inventory.save()
                        total_amount += item.price*item.cnt
                    except Exception,e:
                        Inventory.objects.create(warehouse=self.warehouse,material=item.material,measure=item.measure,
                                                 cnt=item.cnt,price=item.price,org=self.org)
                        item.material.stock_price = item.price
                        item.material.save()

                        item.status=1
                        item.event_time = datetime.datetime.now()
                        item.source = self.code
                        item.save()
                        total_amount += item.price*item.cnt
                    # saving the purchase item
                    item.po_item.is_in_stock = 1
                    item.po_item.in_stock_time = datetime.datetime.now()
                    item.po_item.entry_cnt = item.cnt

                    item.po_item.save()
                    none_zero_left = POItem.objects.filter(po=item.po_item.po,left_cnt__gt=0).count()
                    if none_zero_left == 0:
                        item.po_item.po.status = '99'
                        item.po_item.po.entry_status = 1
                        item.po_item.po.entry_time = datetime.datetime.now()
                        item.po_item.po.save()
                    # saving stock in item status
                    item.status = 1
                    item.event_time = datetime.datetime.now()
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
        ('0', _("NEW")),
        ('1', _("IN PROGRESS")),
        ('9', _("EXECUTED"))
    )
    index_weight = 2
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    project = models.ForeignKey(Project,verbose_name=_("project"),blank=True,null=True)
    wo = models.ForeignKey(WorkOrder,verbose_name=_("work order"),blank=True,null=True)
    description = models.TextField(_("description"),blank=True,null=True)
    amount = models.DecimalField(_("money of amount"),max_digits=14,decimal_places=4,blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("out user"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    execute_time = models.DateTimeField(_("execute time"),blank=True,null=True)

    def out_amount(self):
        return self.amount or ''

    def out_time(self):
        return self.execute_time or ''

    out_time.short_description = _('stock out time')
    out_amount.short_description = _('stock out amount')

    def action_out(self,request=None):
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
                        item.status = 1
                        item.price = item.inventory.price
                        item.event_time = datetime.datetime.now()
                        item.inventory.save()
                        item.source=self.code
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
        ('0', _("NEW")),
        ('1', _("IN PROGRESS")),
        ('9', _("EXECUTED"))
    )
    index_weight = 5
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    out = models.ForeignKey(StockOut,verbose_name=_('StockOut'))
    amount = models.DecimalField(_("money of amount"),max_digits=14,decimal_places=4,blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("out user"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    execute_time = models.DateTimeField(_("execute time"),blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(WareReturn,self).save(force_insert,force_update,using,update_fields)
        item_count = ReturnItem.objects.filter(master=self).count()
        if self.out and item_count == 0:
            for out_item in OutItem.objects.filter(master=self.out):
                ReturnItem.objects.create(master=self,out_item=out_item,material=out_item.material,price=out_item.price,
                                          measure=out_item.measure,warehouse=out_item.warehouse,out_cnt=out_item.cnt,cnt=out_item.cnt)

    def action_return(self,request):
        with transaction.atomic():
            total_amount = decimal.Decimal(0)
            for item in ReturnItem.objects.filter(master=self):
                if item.cnt > item.out_item.cnt or item.cnt < 0:
                    raise Exception('%s cnt is invalid,out is %s,return is %s' % (item.material,item.out_cnt,item.cnt))
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
        ('0', _("NEW")),
        ('1', _("IN PROGRESS")),
        ('9', _("EXECUTED"))
    )
    index_weight = 4
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_("description"),blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("out user"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    execute_time = models.DateTimeField(_("execute time"),blank=True,null=True)

    def action_adjust(self,request):
        with transaction.atomic():
            for item in AdjustItem.objects.filter(master=self,status=0):
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
    """
    in out detail
    """

    PROP = (
        ('+', _("PLUS")),
        ('-', _("MINUS"))
    )

    create_time = models.DateTimeField(_("create time"),auto_now_add=True)
    status = models.BooleanField(_("executed"),default=0)
    event_time = models.DateTimeField(_("event time"),blank=True,null=True)
    warehouse = models.ForeignKey(Warehouse,verbose_name=_("warehouse"),blank=True,null=True)
    material = models.ForeignKey(Material,verbose_name=_("material"),limit_choices_to={"is_virtual":"0"},blank=True,null=True)
    measure = models.ForeignKey(Measure,verbose_name=_("measure"),blank=True,null=True)
    cnt = models.DecimalField(_("count"),max_digits=14,decimal_places=4,blank=True,null=True)
    batch = models.CharField(_("batch"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    price = models.DecimalField(_("price"),max_digits=14,decimal_places=4,blank=True,null=True)
    prop = models.CharField(_("plus or minus property"),max_length=const.DB_CHAR_CODE_2,choices=PROP,default='+')
    source = models.CharField(_("source"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)


class InitItem(InOutDetail):
    """
    期初入库明细
    """
    master = models.ForeignKey(InitialInventory)

    class Meta:
        verbose_name = _("init item")
        verbose_name_plural = _("init item")


class InItem(InOutDetail):
    """
    入库单明细
    """
    master = models.ForeignKey(StockIn)
    po_item = models.ForeignKey(POItem,verbose_name=_("po item"),blank=True,null=True)

    def get_new_price(self):
        if self.po_item and self.master.warehouse:
            try:
                inventory = Inventory.objects.get(warehouse=self.master.warehouse,material=self.material,measure=self.measure)
                if inventory and self.price != inventory.price:
                    total_amount = self.price*self.cnt+inventory.price*inventory.cnt
                    total_count = self.cnt+inventory.cnt
                    return total_amount/total_count
            except Exception,e:
                pass
        return self.price or ''

    class Meta:
        verbose_name = _("in item")
        verbose_name_plural = _("in item")


class InItemForm(forms.ModelForm):

    new_price = forms.CharField(label=_('new price'),required=False)

    class Meta:
        model = InItem
        fields = ('material', 'measure', 'cnt', 'price')


class OutItem(InOutDetail):
    """
    出库单明细
    """
    master = models.ForeignKey(StockOut)
    inventory = models.ForeignKey(Inventory,blank=True,null=True,verbose_name=_("inventory material"))

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        self.prop = '-'
        if self.inventory:
            self.material = self.inventory.material
            self.measure = self.inventory.measure
            self.warehouse = self.inventory.warehouse

        super(OutItem,self).save(force_insert,force_update,using,update_fields)

    class Meta:
        verbose_name = _("out item")
        verbose_name_plural = _("out item")


class ReturnItem(InOutDetail):
    """
    返库单明细
    """
    master = models.ForeignKey(WareReturn)
    out_item = models.ForeignKey(OutItem,blank=True,null=True,verbose_name=_('out item'))
    out_cnt = models.DecimalField(_("out count"),max_digits=14,decimal_places=4)

    class Meta:
        verbose_name = _("return item")
        verbose_name_plural = _("return item")


class AdjustItem(InOutDetail):
    """
    库存调整明细
    """
    master = models.ForeignKey(WareAdjust)
    inventory = models.ForeignKey(Inventory,blank=True,null=True,verbose_name=_("inventory material"))

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.inventory:
            self.material = self.inventory.material
            self.measure = self.inventory.measure
            self.warehouse = self.inventory.warehouse
        super(AdjustItem,self).save(force_insert,force_update,using,update_fields)

    class Meta:
        verbose_name = _("adjust item")
        verbose_name_plural = _("adjust item")