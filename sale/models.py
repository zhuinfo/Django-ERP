# coding=utf-8
import decimal
import datetime
import csv
import os
import xlrd
from mis import settings
from django.db import models
from django.db import transaction
from django.db.models.aggregates import Sum
from django.contrib.auth.models import User
from django.utils.text import force_text
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const
from basedata.models import Material,Project,Partner,Organization,Measure,BankAccount


class SaleOrder(generic.BO):
    """
    销售订单
    """
    STATUS = (
        ('0', _("NEW")),
        ('1', _("IN PROGRESS")),
        ('4', _("DROP")),
        ('9', _("APPROVED")),
        ('99', _("ALREADY STOCK OUT")),
    )
    index_weight = 2
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),limit_choices_to={"partner_type":"C"})
    order_date = models.DateField(_("order date"))
    deliver_date = models.DateField(_("deliver date"))
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_("memo"),blank=True,null=True)
    contact = models.CharField(_("contacts"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    fax = models.CharField(_("fax"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    deliver_address = models.CharField(_("deliver address"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    invoice_type = models.CharField(_("invoice type"),max_length=const.DB_CHAR_CODE_6,choices=const.get_value_list('S053'),default='10')

    amount = models.DecimalField(_("money amount"),max_digits=12,decimal_places=2,blank=True,null=True,default=0.00)
    discount_amount = models.DecimalField(_("discount amount"),max_digits=12,decimal_places=2,blank=True,null=True,default=0.00)
    user = models.ForeignKey(User,verbose_name=_("sales man"),blank=True,null=True)
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)

    def __unicode__(self):
        return u'%s %s' % (self.code,self.title)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(SaleOrder,self).save(force_insert,force_update,using,update_fields)
        if self.discount_amount > 0:
            sql = 'UPDATE sale_saleitem a SET a.discount_price = a.sale_price - ' \
                  '((SELECT discount_amount/amount FROM sale_saleorder WHERE id = %s) * (a.sale_price*a.cnt)/a.cnt) WHERE a.master_id = %s'
            params = [self.id,self.id]
            generic.update(sql,params)

    def collection_amount(self):
        return PaymentCollection.objects.filter(so=self).aggregate(Sum('collection_amount')).get('collection_amount__sum') or 0.00

    collection_amount.short_description = _('collection amount')

    class Meta:
        verbose_name = _('sale order')
        verbose_name_plural = _('sale order')


class SaleItem(models.Model):
    """
    订单明细
    """
    master = models.ForeignKey(SaleOrder)
    material = models.ForeignKey(Material,verbose_name=_("material"),limit_choices_to={"is_virtual":"0",'can_sale':'1'},blank=True,null=True)
    measure = models.ForeignKey(Measure,verbose_name=_("measure"),blank=True,null=True)
    cnt = models.DecimalField(_("count"),max_digits=14,decimal_places=4)
    stock_price = models.DecimalField(_("stock price"),max_digits=14,decimal_places=4,blank=True,null=True)
    sale_price = models.DecimalField(_("sale price"),max_digits=14,decimal_places=4,blank=True,null=True)
    discount_price = models.DecimalField(_("discount price"),max_digits=14,decimal_places=4,blank=True,null=True)
    tax = models.CharField(_("tax rate"),max_length=const.DB_CHAR_CODE_6,choices=const.get_value_list('S052'),default='0.00')
    create_time = models.DateTimeField(_("create time"),auto_now_add=True)
    status = models.BooleanField(_("executed"),default=0)
    event_time = models.DateTimeField(_("event time"),blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.material and self.material.measure.count() > 0:
            self.measure = self.material.measure.all()[0]
        if self.material.sale_price or self.material.stock_price:
            self.sale_price = self.material.sale_price or self.material.stock_price*decimal.Decimal(1.17)/decimal.Decimal(0.6)
        super(SaleItem,self).save(force_insert,force_update,using,update_fields)
        sql = 'update sale_saleorder set amount = (select sum(sale_price*cnt) from sale_saleitem where master_id=%s) where id=%s'
        params = [self.master.id,self.master.id]
        # print sql % (self.master.id,self.master.id)
        generic.update(sql,params)

    class Meta:
        verbose_name = _('order detail')
        verbose_name_plural = _('order detail')


class PaymentCollection(generic.BO):
    """
    销售回款
    """
    index_weight = 3
    collection_date = models.DateField(_("collection date"),blank=True,null=True,default=datetime.date.today)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    code = models.CharField(_("collection code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    so = models.ForeignKey(SaleOrder,verbose_name=_("sale order"))
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),blank=True,null=True)
    order_amount = models.DecimalField(_("order amount"),max_digits=14,decimal_places=4,blank=True,null=True)
    collection_amount = models.DecimalField(_("collection amount"),max_digits=14,decimal_places=4)
    bank = models.ForeignKey(BankAccount,verbose_name=_("bank account"),blank=True,null=True)
    memo = models.TextField(_("memo"),blank=True,null=True)

    def __unicode__(self):
        return u'%s %s'%(self.code,self.so)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.so:
            self.partner = self.so.partner
            self.order_amount = self.so.amount
            if self.so.discount_amount > 0:
                self.order_amount -= self.so.discount_amount
        super(PaymentCollection,self).save(force_insert,force_update,using,update_fields)

    class Meta:
        verbose_name = _('Payment Collection')
        verbose_name_plural = _('Payment Collection')


class OfferSheet(generic.BO):
    """
    报价单
    """
    index_weight = 1
    STATUS = (
        ('0', _("NEW")),
        ('1', _("IN PROGRESS")),
        ('4', _("DROP")),
        ('9', _("APPROVED")),
    )
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),limit_choices_to={"partner_type":"C"})
    offer_date = models.DateField(_("offer date"))
    deliver_date = models.DateField(_("deliver date"))
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_("memo"),blank=True,null=True)

    amount = models.DecimalField(_("money amount"),max_digits=12,decimal_places=2,blank=True,null=True,default=0.00)
    discount_amount = models.DecimalField(_("discount amount"),max_digits=12,decimal_places=2,blank=True,null=True,default=0.00)
    user = models.ForeignKey(User,verbose_name=_("offer man"),blank=True,null=True)

    attach = models.FileField(_('offer sheet file'),blank=True,null=True,upload_to='offer sheet',help_text=u'您可导入报价明细，模板请参考文档FD0006')
    status = models.BooleanField(_("executed"),default=0)
    event_time = models.DateTimeField(_("event time"),blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        import decimal
        super(OfferSheet,self).save(force_insert,force_update,using,update_fields)
        if self.discount_amount > 0:
            sql = 'UPDATE sale_offeritem a SET a.discount_price = a.sale_price - ' \
                  '((SELECT discount_amount/amount FROM sale_offersheet WHERE id = %s) * (a.sale_price*a.cnt)/a.cnt) WHERE a.master_id = %s'
            params = [self.id,self.id]
            # print sql % (self.id,self.id)
            generic.update(sql,params)

        item_count = OfferItem.objects.filter(master=self).count()
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
                        material.sale_price = row[6]
                        material.purchase_price = row[7]
                        material.save()
                    OfferItem.objects.create(master=self,material=material,measure=measure,cnt=row[8],brand=force_text(row[3]),
                                             cost_price=row[7],sale_price=row[6])
                    total_amount += decimal.Decimal(row[6])*decimal.Decimal(row[8])
                sql = 'update sale_offersheet set amount = %s where id=%s'
                params = [total_amount,self.id]
                generic.update(sql,params)

    class Meta:
        verbose_name = _('offer sheet')
        verbose_name_plural = _('offer sheet')


class OfferItem(models.Model):
    """
    订单明细
    """
    master = models.ForeignKey(OfferSheet)
    material = models.ForeignKey(Material,verbose_name=_("material"),limit_choices_to={"is_virtual":"0",'can_sale':'1'},blank=True,null=True)
    measure = models.ForeignKey(Measure,verbose_name=_("measure"),blank=True,null=True)
    cnt = models.DecimalField(_("count"),max_digits=14,decimal_places=4)
    brand = models.CharField(_('brand'),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    cost_price = models.DecimalField(_("cost price"),max_digits=14,decimal_places=4,blank=True,null=True)
    stock_price = models.DecimalField(_("stock price"),max_digits=14,decimal_places=4,blank=True,null=True)
    sale_price = models.DecimalField(_("sale price"),max_digits=14,decimal_places=4,blank=True,null=True)
    discount_price = models.DecimalField(_("discount price"),max_digits=14,decimal_places=4,blank=True,null=True)
    tax = models.CharField(_("tax rate"),max_length=const.DB_CHAR_CODE_6,choices=const.get_value_list('S052'),default='0.00')
    create_time = models.DateTimeField(_("create time"),auto_now_add=True)
    status = models.BooleanField(_("executed"),default=0)
    event_time = models.DateTimeField(_("event time"),blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if self.material and self.material.measure.count() > 0:
            self.measure = self.material.measure.all()[0]
        if self.material.sale_price or self.material.stock_price:
            self.sale_price = self.material.sale_price or self.material.stock_price*decimal.Decimal(1.17)/decimal.Decimal(0.6)
        super(OfferItem,self).save(force_insert,force_update,using,update_fields)
        sql = 'update sale_offersheet set amount = (select sum(sale_price*cnt) from sale_offeritem where master_id=%s) where id=%s'
        params = [self.master.id,self.master.id]
        # print sql % (self.master.id,self.master.id)
        generic.update(sql,params)

    class Meta:
        verbose_name = _('offer detail')
        verbose_name_plural = _('offer detail')