# coding=utf-8
from django.db import models
from django.db import connection
from django.utils.translation import ugettext_lazy as _
from common import const
from common import generic


class Organization(generic.BO):
    """
    组织单位
    """
    index_weight = 1
    code = models.CharField(_("organ code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    name = models.CharField(_("organ name"),max_length=const.DB_CHAR_NAME_120)
    short = models.CharField(_("short name"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    status = models.BooleanField(_("in use"),default=True)

    tax_num = models.CharField(_("tax num"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    tax_address = models.CharField(_("tax address"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    tax_account = models.CharField(_("tax account"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)

    represent = models.CharField(_("representative "),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    address = models.CharField(_("address"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    zipcode = models.CharField(_("zipcode"),max_length=const.DB_CHAR_CODE_8,blank=True,null=True)
    fax = models.CharField(_("fax"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    contacts = models.CharField(_("contacts"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    website = models.CharField(_("website"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    email = models.CharField(_("email"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    lic_code = models.CharField(_("license code"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    cer_code = models.CharField(_("certificate code"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    license = models.FileField(_("business license"),blank=True,null=True,upload_to='organ')
    certificate = models.FileField(_("organization code certificate"),blank=True,null=True,upload_to='organ')
    weight = models.IntegerField(_("weight"),default=9)

    class Meta:
        verbose_name = _('organization')
        verbose_name_plural = _('organization')


class OrgUnit(generic.BO):
    """
    组织单元
    """
    UNIT_LEVEL = (
        (1,_('BRANCH')),
        (2,_('DEPARTMENT')),
        (3,_('OFFICE')),
        (4,_('TEAM')),
        (5,_('COMMITTEE'))
    )
    index_weight = 2
    parent = models.ForeignKey('self',verbose_name=_("parent"),null=True,blank=True)
    organization = models.ForeignKey(Organization,verbose_name = _('organization'),null=True,blank=True)
    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_8,blank=True,null=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_120)
    short = models.CharField(_("short name"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    unit_type = models.IntegerField(_("type"),choices=UNIT_LEVEL,default=2)
    status = models.BooleanField(_("in use"),default=True)
    virtual = models.BooleanField(_("is virtual"),default=False)
    fax = models.CharField(_("fax"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    contacts = models.CharField(_("contacts"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    email = models.CharField(_("email"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    weight = models.IntegerField(_("weight"),default=99)

    class Meta:
        verbose_name = _('org unit')
        verbose_name_plural = _('org unit')


class Position(generic.BO):
    """
    岗位
    """
    SERIES = (
        ('A',_("Admin Position")),
        ('S',_("Sale Position")),
        ('T',_("Technology Position")),
        ('P',_("Produce Position")),
    )

    GRADE = (
        ('01', _("BASIC")),
        ('02', _("MEDIUM")),
        ('03', _("SENIOR")),
        ('04', _("PROFESSOR")),
        ('05', _("EXPERT")),
    )
    index_weight = 3
    unit = models.ForeignKey(OrgUnit,verbose_name=_('org unit'))
    organization = models.ForeignKey(Organization,verbose_name=_('organization'),null=True,blank=True)
    parent = models.ForeignKey('self',verbose_name=_("parent"),null=True,blank=True)
    code = models.CharField(_("position code"),max_length=const.DB_CHAR_CODE_8,blank=True,null=True)
    name = models.CharField(_("position name"),max_length=const.DB_CHAR_NAME_120)
    short = models.CharField(_("short name"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    series = models.CharField(_("position series"),max_length=1,default='A',choices=const.get_value_list('S014'))
    grade =  models.CharField(_("position grade"),max_length=const.DB_CHAR_CODE_2,default='01',choices=const.get_value_list('S015'))
    virtual = models.BooleanField(_("is virtual"),default=False)
    status = models.BooleanField(_("in use"),default=True)
    description = models.TextField(_("position description"),blank=True,null=True)
    qualification = models.TextField(_("qualification"),blank=True,null=True)
    document = models.FileField(_("reference"),blank=True,null=True)
    weight = models.IntegerField(_("weight"),default=99)

    def __unicode__(self):
        return u'%s %s' % (self.code,self.name)

    class Meta:
        verbose_name = _('position')
        verbose_name_plural = _('position')
