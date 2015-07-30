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
from django.utils.text import force_text
from mis import settings
from common import generic
from common import const
from selfhelp.models import WOItem
from basedata.models import Material,Organization,Partner,Measure,BankAccount


class PurchaseOrder(generic.BO):
    """

    """
    STATUS = (
        ('0', _("NEW")),
        ('1', _("IN PROGRESS")),
        ('4', _("DROP")),
        ('9', _("APPROVED")),
        ('99', _("ALREADY STOCK IN")),
    )
    index_weight = 1
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),limit_choices_to={"partner_type":"S"})
    order_date = models.DateField(_("order date"))
    arrive_date = models.DateField(_("arrive date"))
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_("description"),blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    amount = models.DecimalField(_("money amount"),max_digits=12,decimal_places=2,blank=True,null=True,default=0.00)
    discount_amount = models.DecimalField(_("discount amount"),max_digits=12,decimal_places=2,blank=True,null=True,default=0.00)
    entry_status = models.BooleanField(_("entry status"),default=0)
    entry_time = models.DateTimeField(_("entry time"),blank=True,null=True)
    attach = models.FileField(_('attach'),blank=True,null=True,help_text=u'您可导入采购明细，模板请参考文档FD0008')

    def __unicode__(self):
        return u'%s %s' % (self.code,self.title)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(PurchaseOrder,self).save(force_insert,force_update,using,update_fields)
        if self.discount_amount > 0:
            sql = 'UPDATE purchase_poitem a SET a.discount_price = ' \
                  'a.price-((SELECT discount_amount/amount FROM purchase_purchaseorder WHERE id=%s)*a.amount/a.cnt) WHERE a.po_id = %s'
            params = [self.id,self.id]
            generic.update(sql,params)

        item_count = POItem.objects.filter(po=self).count()
        if self.attach and item_count == 0:
            path = os.path.join(settings.MEDIA_ROOT,self.attach.name)
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
                    except Exception,e:
                        measure = Measure.objects.create(code=row[4],name=force_text(row[5]))

                    try:
                        material = Material.objects.get(code=row[0])
                    except Exception,e:
                        material = Material(code=row[0],name=force_text(row[1]),spec=force_text(row[2]))
                        material.purchase_price = row[6]
                        material.save()
                    amount = decimal.Decimal(row[6])*decimal.Decimal(row[7])
                    POItem.objects.create(po=self,material=material,measure=measure,cnt=row[7],price=row[6],amount=amount)
                    total_amount += amount
                sql = 'update purchase_purchaseorder set amount = %s where id=%s'
                params = [total_amount,self.id]
                generic.update(sql,params)

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

    """
    index_weight = 2
    po = models.ForeignKey(PurchaseOrder,verbose_name=_("purchase order"))
    material = models.ForeignKey(Material,verbose_name=_("material"),limit_choices_to={"is_virtual":"0"})
    measure = models.ForeignKey(Measure,verbose_name=_("measure"),blank=True,null=True)
    price = models.DecimalField(_("price"),max_digits=12,decimal_places=4,blank=True,null=True)
    cnt = models.DecimalField(_("count"),max_digits=12,decimal_places=4,blank=True,null=True)
    discount_price = models.DecimalField(_("discount price"),max_digits=12,decimal_places=4,blank=True,null=True)
    amount = models.DecimalField(_("money of amount"),max_digits=12,decimal_places=2,blank=True,null=True)
    discount_amount = models.DecimalField(_("discount amount"),max_digits=12,decimal_places=2,blank=True,null=True)
    tax = models.CharField(_("tax rate"),max_length=const.DB_CHAR_CODE_6,choices=const.get_value_list('S052'),default='0.00')
    woitem = models.ForeignKey(WOItem,verbose_name=_("wo item"),blank=True,null=True)
    is_in_stock = models.BooleanField(_("is in stock"),default=0)
    in_stock_time = models.DateTimeField(_("execute time"),blank=True,null=True)
    entry_cnt = models.DecimalField(_("entry count"),max_digits=12,decimal_places=4,blank=True,null=True)
    left_cnt = models.DecimalField(_("left count"),max_digits=12,decimal_places=4,blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.price and self.cnt:
            money = self.price * self.cnt
            self.amount = money

        if self.measure is None and self.material and self.material.measure.count() > 0:
            self.measure = self.material.measure.all()[0]

        if self.is_in_stock:
            self.left_cnt -= self.entry_cnt
        else:
            self.left_cnt = self.cnt
        super(POItem,self).save(force_insert,force_update,using,update_fields)
        self.material.purchase_price = self.price
        self.material.save()
        sql = 'UPDATE purchase_purchaseorder SET amount = (SELECT SUM(a.price*a.cnt) AS amount FROM ' \
                  'purchase_poitem a WHERE a.po_id = %s) WHERE id = %s'
        params = [self.po.id,self.po.id]
        generic.update(sql,params)

    def vender(self):
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
    vo_date = models.DateField(_("invoice date"),blank=True,null=True,default=datetime.date.today)
    code = models.CharField(_("invoice code"),max_length=const.DB_CHAR_NAME_20)
    number = models.CharField(_("invoice number"),max_length=const.DB_CHAR_NAME_20)
    po = models.ForeignKey(PurchaseOrder,verbose_name=_("purchase order"))
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),blank=True,null=True)
    po_amount = models.DecimalField(_("po amount"),max_digits=14,decimal_places=4,blank=True,null=True)
    vo_amount = models.DecimalField(_("invoice amount"),max_digits=14,decimal_places=4)
    file = models.FileField(_("invoice file"),upload_to='invoice',blank=True,null=True)

    def __unicode__(self):
        return u"%s %s" % (self.code,self.partner)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.po:
            self.partner = self.po.partner
            self.po_amount = self.po.amount
        super(Invoice,self).save(force_insert,force_update,using,update_fields)

    class Meta:
        verbose_name = _("Invoice")
        verbose_name_plural = _("Invoice")


class Payment(generic.BO):
    """
    采购付款
    """
    index_weight = 3
    py_date = models.DateField(_("pay date"),blank=True,null=True,default=datetime.date.today)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    code = models.CharField(_("pay code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    po = models.ForeignKey(PurchaseOrder,verbose_name=_("purchase order"))
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),blank=True,null=True)
    po_amount = models.DecimalField(_("po amount"),max_digits=14,decimal_places=4,blank=True,null=True)
    py_amount = models.DecimalField(_("pay amount"),max_digits=14,decimal_places=4)
    bank = models.ForeignKey(BankAccount,verbose_name=_("bank account"),blank=True,null=True)
    response_code = models.CharField(_("response code"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    memo = models.TextField(_("memo"),blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.po:
            self.partner = self.po.partner
            self.po_amount = self.po.amount
        super(Payment,self).save(force_insert,force_update,using,update_fields)

    def __unicode__(self):
        return u"%s %s" % (self.code,self.partner)

    class Meta:
        verbose_name = _("Payment")
        verbose_name_plural = _("Payment")