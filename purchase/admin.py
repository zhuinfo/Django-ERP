from django.contrib import admin
from common import generic
from purchase.models import PurchaseOrder,POItem,Invoice,Payment
from basedata.models import Partner,BankAccount


class POItemInline(admin.TabularInline):
    model = POItem
    fields = ('material', 'measure','price', 'cnt', 'tax', 'discount_price')
    raw_id_fields = ['material']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 3


class PurchaseOrderAdmin(generic.BOAdmin):
    """

    """
    CODE_PREFIX = 'CG'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','title','order_date','partner','amount','discount_amount','payed_amount','invoice_amount','status']
    list_display_links = ['code','title']
    raw_id_fields = ['partner']
    fields = (
        ('code','partner'),('order_date','arrive_date'),
        ('title','status',),('description',),('amount','discount_amount'),('attach',),
    )
    readonly_fields = ['status','amount']
    inlines = [POItemInline]
    date_hierarchy = 'begin'

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        if object_id:
            extra_context = extra_context or {}
            obj = PurchaseOrder.objects.get(id=object_id)
            if obj.status == '99':
                extra_context.update(dict(readonly=True))
        return super(PurchaseOrderAdmin,self).changeform_view(request,object_id,form_url,extra_context)

    def get_changeform_initial_data(self, request):
        import datetime
        begin = datetime.date.today()
        end = begin + datetime.timedelta(30)
        return {'order_date':begin,'arrive_date':end}


class PurchaseItemAdmin(generic.BOAdmin):
    list_display = ['po','vender','material','cnt','price','tax']
    readonly_fields = ['po','material','cnt','price','tax']

    def get_queryset(self, request):
        return POItem.objects.filter(left_cnt__gt=0)


class InvoiceAdmin(generic.BOAdmin):
    list_display = ['code','number','vo_date','po','partner','po_amount','vo_amount']
    readonly_fields = ['partner','po_amount']
    raw_id_fields = ['po']
    search_fields = ['po__code','partner__name']
    date_hierarchy = 'begin'
    fields = (
        ('vo_date',),('po',),('po_amount','partner',),('code',),('number',),('vo_amount',),('file',)
    )


class PaymentAdmin(generic.BOAdmin):
    CODE_PREFIX = 'PY'
    CODE_NUMBER_WIDTH = 4
    list_display = ['code','py_date','po','partner','po_amount','py_amount']
    readonly_fields = ['partner','po_amount']
    raw_id_fields = ['po']
    search_fields = ['po__code','partner__name']
    fields = (
        ('py_date','code',),('po',),('partner','po_amount',),('py_amount',),('bank',),('response_code'),('memo',)
    )
    date_hierarchy = 'begin'

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):
        if db_field.name == 'bank':
            kwargs['queryset'] = BankAccount.objects.exclude(org__exact=None)
        return super(PaymentAdmin,self).formfield_for_foreignkey(db_field,request,**kwargs)

admin.site.register(PurchaseOrder,PurchaseOrderAdmin)
admin.site.register(POItem,PurchaseItemAdmin)
admin.site.register(Invoice,InvoiceAdmin)
admin.site.register(Payment,PaymentAdmin)
