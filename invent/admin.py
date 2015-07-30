from django.contrib import admin
from django.utils.translation import ugettext_lazy as _
from common import generic
from basedata.models import Material
from invent.models import StockIn,StockOut,InitialInventory,InItem,OutItem,InitItem,Inventory,InItemForm,InOutDetail,\
    WareReturn,ReturnItem,WareAdjust,AdjustItem


class InItemInline(admin.TabularInline):
    model = InItem
    form = InItemForm
    fields = ('material', 'measure', 'cnt', 'price')
    raw_id_fields = ['material']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 1

    def get_readonly_fields(self, request, obj=None):
        if obj and obj.status == 1:
            return ['material', 'measure', 'cnt', 'price']
        else:
            return []

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):
        if db_field.name == 'material':
            kwargs['queryset'] = Material.objects.filter(is_virtual=0)
        return super(InItemInline,self).formfield_for_foreignkey(db_field,request,**kwargs)


class OutItemInline(admin.TabularInline):
    model = OutItem
    fields = ('inventory', 'measure', 'cnt', 'price','warehouse',)
    raw_id_fields = ['inventory']
    readonly_fields = ['measure', 'price', 'warehouse']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 3


class InitItemInline(admin.TabularInline):
    model = InitItem
    fields = ('material', 'measure', 'cnt', 'warehouse', 'price',)
    raw_id_fields = ['material']

    def get_readonly_fields(self, request, obj=None):
        if obj and obj.execute_time:
            return ['material', 'measure', 'cnt', 'warehouse', 'price']
        else:
            return []

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 3

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):
        if db_field.name == 'material':
            kwargs['queryset'] = Material.objects.filter(is_virtual=0)
        return super(InitItemInline,self).formfield_for_foreignkey(db_field,request,**kwargs)


class StockInAdmin(generic.BOAdmin):
    CODE_PREFIX = 'RK'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','title','money_of_amount','status','entry_time']
    inlines = [InItemInline]
    raw_id_fields = ['po']
    fields = (
        ('code',),('title',),('po',),('warehouse',),('batch',),('status','amount',)
    )
    date_hierarchy = 'begin'
    extra_buttons = [{'href':'cin','title':_('Action Stock In')}]

    def save_model(self, request, obj, form, change):
        import decimal
        super(StockInAdmin,self).save_model(request,obj,form,change)
        if obj and obj.po:
            po_items = obj.po.poitem_set.filter(left_cnt__gt=0).all()
            for item in po_items:
                try:
                    InItem.objects.get(po_item=item,master=obj)
                    continue
                except Exception,e:
                    pp = item.discount_price or item.price
                    if decimal.Decimal(item.tax) > decimal.Decimal(0):
                        pp = pp /(decimal.Decimal(1)+decimal.Decimal(item.tax))
                    InItem.objects.create(warehouse=obj.warehouse,material=item.material,measure=item.measure,prop='+',
                                                po_item=item,master=obj,cnt=item.left_cnt,price=pp,batch=obj.batch,source=obj.code)

    def get_readonly_fields(self, request, obj=None):
        print obj
        if obj and obj.status == 9:
            return ['code','title','po','warehouse','batch','status']
        else:
            return ['status','amount']

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        extra_context = extra_context or {}
        if object_id:
            obj = StockIn.objects.get(id=object_id)
            if obj and obj.execute_time:
                extra_context.update(dict(readonly=True))
        return super(StockInAdmin,self).changeform_view(request,object_id,form_url,extra_context)


class StockOutAdmin(generic.BOAdmin):
    CODE_PREFIX = 'CK'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','title','project','status','out_time','out_amount']
    list_display_links = ['code','title']
    date_hierarchy = 'begin'
    inlines = [OutItemInline]
    raw_id_fields = ['project','wo','user']
    fields = (
        ('code', 'status',),('project', ),('wo','user'),
        ('title','amount',),('description',),
    )
    readonly_fields = ['status']
    extra_buttons = [{'href':'out','title':_('Action Stock Out')}]
    search_fields = ['code','title','user__username']

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        extra_context = extra_context or {}
        if object_id:
            obj = StockOut.objects.get(id=object_id)
            if obj and obj.execute_time:
                extra_context.update(dict(readonly=True))
        return super(StockOutAdmin,self).changeform_view(request,object_id,form_url,extra_context)

    def save_model(self, request, obj, form, change):
        if obj and obj.user is None:
            obj.user = request.user
        super(StockOutAdmin,self).save_model(request,obj,form,change)


class InitialInventoryAdmin(generic.BOAdmin):
    CODE_PREFIX = 'QC'
    CODE_NUMBER_WIDTH = 3
    list_display = ['code','title','status']
    inlines = [InitItemInline]
    fields = ('code','title','org','status','amount','attach')
    readonly_fields = ['status','amount']
    extra_buttons = [{'href':'cin','title':_('Action Stock In')}]

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        extra_context = extra_context or {}
        if object_id:
            obj = InitialInventory.objects.get(id=object_id)
            if obj and obj.execute_time:
                extra_context.update(dict(readonly=True))
        return super(InitialInventoryAdmin,self).changeform_view(request,object_id,form_url,extra_context)


class InventoryAdmin(generic.BOAdmin):
    list_display = ['material','measure','warehouse','cnt','price']
    search_fields = ['material__name','material__code']

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        extra_context = extra_context or {}
        extra_context.update(dict(readonly=True))
        if object_id:
            inventory = Inventory.objects.get(id=object_id)
            material = inventory.material
            warehouse = inventory.warehouse
            detail = InOutDetail.objects.filter(material=material,warehouse=warehouse)
            extra_context.update(dict(detail=detail))

        return super(InventoryAdmin,self).changeform_view(request,object_id,form_url,extra_context)


class ReturnItemInline(admin.TabularInline):
    model = ReturnItem
    fields = ['material','measure','warehouse','out_cnt','cnt']
    readonly_fields = ['material','measure','warehouse','out_cnt']
    extra = 0


class WareReturnAdmin(generic.BOAdmin):
    """

    """
    CODE_PREFIX = 'FK'
    CODE_NUMBER_WIDTH = 4
    list_display = ['code','title','out']
    fields = (
        ('code',),('title',),('out',),('amount',),('status',)
    )
    readonly_fields = ['status']
    raw_id_fields = ['out']
    inlines = [ReturnItemInline]
    extra_buttons = [{'href':'cin','title':_('Action Ware Return')}]

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        if object_id :
            obj = WareReturn.objects.get(id=object_id)
            if obj.status == '9':
                extra_context = extra_context or {}
                extra_context.update(dict(readonly=True))
        return super(WareReturnAdmin,self).changeform_view(request,object_id,form_url,extra_context)


class AdjustItemInline(admin.TabularInline):
    model = AdjustItem
    fields = ['inventory','measure','warehouse','prop','cnt']
    readonly_fields = ['measure','warehouse']
    raw_id_fields = ['inventory']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 1


class WareAdjustAdmin(generic.BOAdmin):
    CODE_PREFIX = 'TZ'
    CODE_NUMBER_WIDTH = 3
    list_display = ['code','title','status']
    fields = (
        ('code',),('title',),('description',),('status',)
    )
    readonly_fields = ['status']
    inlines = [AdjustItemInline]
    extra_buttons = [{'href':'adjust','title':_('Action Ware Adjust')}]
    date_hierarchy = 'begin'

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        if object_id:
            obj = WareAdjust.objects.get(id=object_id)
            if obj and obj.status == '9':
                extra_context = extra_context or {}
                extra_context.update(dict(readonly=True))
        return super(WareAdjustAdmin,self).changeform_view(request,object_id,form_url,extra_context)


admin.site.register(StockIn,StockInAdmin)
admin.site.register(StockOut,StockOutAdmin)
admin.site.register(InitialInventory,InitialInventoryAdmin)
admin.site.register(Inventory,InventoryAdmin)
admin.site.register(WareReturn,WareReturnAdmin)
admin.site.register(WareAdjust,WareAdjustAdmin)
