# coding=utf-8
from django.contrib import admin
from common import generic
from organ.models import Organization,OrgUnit,Position
from basedata.models import BankAccount
from basedata.admin import BankAccountInline
import datetime


class OrgAdmin(generic.BOAdmin):
    CODE_PREFIX = 'O'
    CODE_NUMBER_WIDTH = 2
    list_display = ['code','name','represent','lic_code','cer_code']

    fields = (
        ('name','code',),('short','pinyin',),
        ('tax_num','tax_account',),('tax_address',),('represent','email',),
        ('address','zipcode',),('contacts','phone',),('fax','website',),
        ('lic_code','cer_code',),('license','certificate',),('status','weight',),
    )

    inlines = [BankAccountInline]


class OrgUnitAdmin(generic.BOAdmin):
    CODE_PREFIX = 'S'
    CODE_NUMBER_WIDTH = 3
    list_display = ['code','name','unit_type','parent']
    list_display_links = ['code','name']
    fields = (
        ('organization',),('parent',),('name','code',),('short','pinyin',),
        ('unit_type',),('status','virtual',),('phone','fax',),
        ('contacts','email',),('weight',),
    )

    def get_queryset(self, request):
        return super(OrgUnitAdmin,self).get_queryset(request).filter(end__gt=datetime.date.today())

    def save_model(self, request, obj, form, change):
        if obj.parent and obj.parent.organization:
            obj.organization = obj.parent.organization
            obj.save()
        super(OrgUnitAdmin,self).save_model(request,obj,form,change)


class PositionAdmin(generic.BOAdmin):
    CODE_PREFIX = 'P'
    CODE_NUMBER_WIDTH = 4
    list_display = ['code','name','unit','series','grade','parent']
    list_display_links = ['code','name']
    fields = (
        ('unit',),('organization',),('parent',),('name','code',),('short','pinyin',),('series','grade',),
        ('virtual','status'),('description',),('qualification',),('document',),('weight',),
    )
    readonly_fields = ['organization']

    def get_queryset(self, request):
        return super(PositionAdmin,self).get_queryset(request).filter(end__gt=datetime.date.today())

    def save_model(self, request, obj, form, change):
        if obj.unit:
            obj.organization = obj.unit.organization
            obj.save()
        super(PositionAdmin,self).save_model(request,obj,form,change)

admin.site.register(Position,PositionAdmin)
admin.site.register(OrgUnit,OrgUnitAdmin)
admin.site.register(Organization,OrgAdmin)