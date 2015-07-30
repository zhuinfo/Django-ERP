# coding=utf-8
from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const
from basedata.models import Position,Employee
from organ.models import OrgUnit
import datetime


class SalaryItemHandler:
    code = None

    def __init__(self,employee):
        self.employee = employee

    def value(self):
        return 0


class SalaryItem(models.Model):
    """
    工资项
    """
    formulas = {}

    @classmethod
    def add_formula(cls, code, handler):
        SalaryItem.formulas[code] = handler

    @classmethod
    def get_formula(cls):
        return SalaryItem.formulas.get(cls.code,None)

    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_10,null=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_120)
    classification = models.CharField(_("classification"),max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('S048'),default='10')
    plus_or_minus = models.CharField(_("plus or minus"),max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('S049'),default='+')
    required = models.BooleanField(_("is required"),default=0)

    def __unicode__(self):
        return "%s %s" % (self.code,self.name)

    class Meta:
        verbose_name = _('salary item')
        verbose_name_plural = _('salary items')
        ordering = ('code',)


class Entry(generic.BO):
    """
    人员入职
    """
    code = models.CharField(_("employee number"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    name = models.CharField(_("employee name"),max_length=const.DB_CHAR_NAME_120)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    birthday = models.DateField(_("birthday"),blank=True,null=True)
    gender = models.CharField(_("gender"),max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('gender'),default='1')
    idcard = models.CharField(_("id card"),max_length=const.DB_CHAR_NAME_20)
    address = models.CharField(_("mail address"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    zipcode = models.CharField(_("zipcode"),max_length=const.DB_CHAR_CODE_8)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)

    guider = models.ForeignKey(Employee,verbose_name=_("guider"))
    position = models.ForeignKey(Position,verbose_name = _('designate position'))
    rank = models.CharField(_("employee rank"),max_length=const.DB_CHAR_CODE_2,default='00',choices=const.get_value_list('S017'))
    ygxs = models.CharField(_("employ ygxs"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S019'),default='2')
    category = models.CharField(_("employ category"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S018'),default='21')

    probation_months = models.CharField(_("probation months"),max_length=2,default='3',choices=const.get_value_list('S047'))
    probation_begin = models.DateField(_("probation begin"),default=datetime.date.today)
    probation_end = models.DateField(_("probation end"),blank=True,null=True)

    memo = models.TextField(_("memo"),blank=True,null=True)
    profile = models.FileField(_("profile"),blank=True,null=True,upload_to='hr profile')

    class Meta:
        verbose_name = _("employee entry")
        verbose_name_plural = _("employee entries")
        permissions = (
            ('modify_salary_item',_("modify salary item")),
        )


class EmployeeSalaryItem(models.Model):
    """

    """
    entry = models.ForeignKey(Entry,verbose_name=_("employee entry"))
    employee = models.ForeignKey(Employee,verbose_name=_("employee"),blank=True,null=True)
    salary_item = models.ForeignKey(SalaryItem,verbose_name=_("salary item"))
    calculate_way = models.CharField(_("calculate way"),max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('S050'),default='10')
    fixed_value = models.DecimalField(_("fixed value"),blank=True,null=True,max_digits=10,decimal_places=2)
    base_value = models.DecimalField(_("base value"),blank=True,null=True,max_digits=10,decimal_places=2)
    org_percent = models.DecimalField(_("org percent"),blank=True,null=True,max_digits=4,decimal_places=2)
    employee_percent = models.DecimalField(_("employee percent"),blank=True,null=True,max_digits=4,decimal_places=2)

    class Meta:
        verbose_name = _("salary item")
        verbose_name_plural = _("salary item")
        unique_together = (('entry', 'salary_item'),)


class Transfer(generic.BO):
    """
    人员调动
    """
    employee = models.ForeignKey(Employee,verbose_name=_("employee"))

    class Meta:
        verbose_name = _("employee transfer")
        verbose_name_plural = _("employee transfers")


class Departure(generic.BO):
    """
    人员离职
    """
    employee = models.ForeignKey(Employee,verbose_name=_("employee"))

    class Meta:
        verbose_name = _("employee departure")
        verbose_name_plural = _("employee departures")

