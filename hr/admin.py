# coding = utf-8
from django.contrib import admin
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const
from hr.models import Entry,SalaryItem,EmployeeSalaryItem


class SalaryItemAdmin(admin.ModelAdmin):
    list_display = ['code','classification','name','plus_or_minus','required']
    list_display_links = ['code','name']
    list_per_page = 20


class EmployeeSalaryItemInline(admin.TabularInline):
    model = EmployeeSalaryItem
    exclude = ['employee']

    def formfield_for_foreignkey(self, db_field, request=None, **kwargs):
        if db_field.name == 'salary_item':
            kwargs['queryset'] = SalaryItem.objects.filter(required=1)

        return super(EmployeeSalaryItemInline,self).formfield_for_foreignkey(db_field,request,**kwargs)

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 3


class EntryAdmin(generic.BOAdmin):
    list_display = ['code','name','gender','position','rank','probation_months','probation_end']
    inlines = [EmployeeSalaryItemInline]
    fieldsets = [
        (None,{'fields':[('code','position',),('name','pinyin',),('address','zipcode',),('idcard','phone',),('memo',),('profile',)]}),
        (_('org distribute'),{'fields':[('guider',),('rank','ygxs',),('category','probation_months',),('probation_begin','probation_end',)],'classes': ['collapse']})
    ]
    raw_id_fields = ['position','guider']
    def get_changeform_initial_data(self, request):
        import datetime
        end = datetime.date.today()+datetime.timedelta(90)
        return {'probation_end':end}


admin.site.register(SalaryItem,SalaryItemAdmin)
admin.site.register(Entry,EntryAdmin)