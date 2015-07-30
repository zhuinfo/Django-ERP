# coding=utf-8
# coding = utf-8
import datetime
from django.contrib import admin
from django.contrib import messages
from django.http import HttpResponseRedirect
from django.db.models.aggregates import Sum
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const
from basedata.models import Material,ExtraParam,Employee,Position
from selfhelp.models import WorkOrder,WOExtraValue,WOItem,Reimbursement,ReimbursementItem,Loan,Enroll,Feedback,Activity


class ParamValueInline(admin.TabularInline):
    model = WOExtraValue
    fields = ('param_name','param_value')
    readonly_fields = ['param_name']

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):

        if db_field.name == 'param_name':
            app_info = generic.get_app_model_info_from_request(request)
            instance = app_info['obj']
            if instance:
                kwargs['queryset'] = ExtraParam.objects.filter(material=instance.service)

        return super(ParamValueInline,self).formfield_for_foreignkey(db_field,request,**kwargs)

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 1


class ItemInline(admin.TabularInline):
    model = WOItem
    raw_id_fields = ['material']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 1


class WorkOrderAdmin(generic.BOAdmin):
    """

    """
    CODE_PREFIX = 'WO'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','begin','title','classification','business_domain','status']
    list_display_links = ['code','title']
    exclude = ['creator','modifier','creation','modification']
    search_fields = ['code','title']
    list_filter = ['classification','service','status']
    fields = (
        ('begin','end',),
        ('code','refer',),('classification','business_domain',),
        ('service','project',),
        ('title','status',),('description',),('attach',),('detail',)
    )
    readonly_fields = ['status']
    raw_id_fields = ['service','project','refer']
    inlines = [ItemInline,ParamValueInline]
    date_hierarchy = 'begin'

    def save_model(self, request, obj, form, change):
        if obj.user is None:
            obj.user = request.user
        super(WorkOrderAdmin,self).save_model(request,obj,form,change)

    def get_changeform_initial_data(self, request):
        import datetime
        td = datetime.date.today()
        end = td + datetime.timedelta(30)
        return {'begin':datetime.date.today, 'end':end}

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):
        if db_field.name == 'refer':
            app_info = generic.get_app_model_info_from_request(request)
            if app_info and app_info['obj']:
                kwargs['queryset'] = WorkOrder.objects.exclude(id=app_info['id'])

        return super(WorkOrderAdmin,self).formfield_for_foreignkey(db_field,request,**kwargs)


class LoanAdmin(generic.BOAdmin):
    CODE_PREFIX = 'JK'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','title','project','loan_amount','applier','status']
    list_display_links = ['code','title']
    readonly_fields = ['status','logout_time','logout_amount']
    raw_id_fields = ['project','user']
    fields = (
        ('code',),('title','loan_amount',),('description',),('project'),('user','status'),('logout_time','logout_amount',),
    )
    extra_buttons = [{'href':'pay','title':_('pay')}]
    search_fields = ['code','title','user__username']
    date_hierarchy = 'begin'

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        if object_id:
            try:
                obj = Loan.objects.get(id=object_id)
                if obj and obj.status == 'P':
                    extra_context = extra_context or {}
                    extra_context.update(dict(readonly=True))
            except Exception,e:
                pass
        return super(LoanAdmin,self).changeform_view(request,object_id,form_url,extra_context)

    def save_model(self, request, obj, form, change):
        if obj and obj.user is None:
            obj.user = request.user
        super(LoanAdmin,self).save_model(request,obj,form,change)


class ReimbursementItemInline(admin.TabularInline):
    model = ReimbursementItem
    raw_id_fields = ['expense_account']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 1


class ReimbursementAdmin(generic.BOAdmin):
    CODE_PREFIX = 'BX'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','title','project','amount','applier','status']
    list_display_links = ['code','title']
    inlines = [ReimbursementItemInline]
    raw_id_fields = ['project','wo','user','org']
    readonly_fields = ['loan_amount','pay_time','status','amount']
    fieldsets = [
        (None,{'fields':[('code','user'),('title','amount','status',),('description',),('project','wo',)]}),
        (_('fico'),{'fields':[('org',),('loan',),('logout_amount','pay_amount',)],'classes': ['collapse']})
    ]
    extra_buttons = [{'href':'pay','title':_('pay')}]
    search_fields = ['code','title','project__code','project__name','user__username']
    date_hierarchy = 'begin'

    def get_changeform_initial_data(self, request):
        apps = generic.get_app_model_info_from_request(request)
        obj = getattr(apps,'obj',None)
        current = request.user
        if obj:
            current = obj.user
        sm = Loan.objects.filter(user=current).aggregate(Sum('loan_amount')).get('loan_amount__sum') or 0.00
        return {'loan_amount':sm}

    def save_model(self, request, obj, form, change):
        if obj and obj.user is None:
            obj.user = request.user

        super(ReimbursementAdmin,self).save_model(request,obj,form,change)

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):
        if db_field.name == 'loan':
            apps = generic.get_app_model_info_from_request(request)
            current = request.user
            if apps:
                obj = apps.get('obj')
                current = obj.user
                if obj.status == 'P':
                    kwargs['queryset']=Loan.objects.filter(id=obj.loan.id)
                else:
                    kwargs['queryset']=Loan.objects.filter(user=current,is_clear=0)
            else:
                kwargs['queryset']=Loan.objects.filter(user=current,is_clear=0)
        return super(ReimbursementAdmin,self).formfield_for_foreignkey(db_field,request,**kwargs)

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        if object_id:
            try:
                obj = Reimbursement.objects.get(id=object_id)
                if obj and obj.status == 'P':
                    extra_context = extra_context or {}
                    extra_context.update(dict(readonly=True))
            except Exception,e:
                pass
        return super(ReimbursementAdmin,self).changeform_view(request,object_id,form_url,extra_context)


class EnrollInline(admin.TabularInline):
    model = Enroll


class FeedbackInline(admin.TabularInline):
    model = Feedback


class ActivityAdmin(generic.BOAdmin):
    CODE_PREFIX = 'AC'
    CODE_NUMBER_WIDTH = 5
    list_display = ['code','begin_time','end_time','title','classification','room']
    list_display_links = ['code','title']
    raw_id_fields = ['room','parent']
    fieldsets = [
        (None,{'fields':[('begin_time','end_time',),('title','classification',),('description',),
                         ('host','speaker',),('room','location',),('attach',)]}),
        (_('other info'),{'fields':[('mail_list',),('parent',),('mail_notice','short_message_notice','weixin_notice',)],'classes': ['collapse']})
    ]

    def get_changeform_initial_data(self, request):
        now = datetime.datetime.now()
        begin = now + datetime.timedelta(hours=12)
        end = begin + datetime.timedelta(hours=6)
        return {'begin_time':begin,'end_time':end}

admin.site.register(WorkOrder,WorkOrderAdmin)
admin.site.register(Loan,LoanAdmin)
admin.site.register(Reimbursement,ReimbursementAdmin)
admin.site.register(Activity,ActivityAdmin)
