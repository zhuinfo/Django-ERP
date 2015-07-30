# coding=utf-8
from django.db import models
from django.contrib.auth.models import User
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from django.utils.translation import ugettext_lazy as _
from django.utils.text import force_text
from common import const
from common import generic
from syscfg.models import Module,Site
from organ.models import Organization,Position
import datetime
from plugin.xls import ExcelManager


class ValueList(generic.BO):
    """
    值列表
    """
    index_weight = 9
    code = models.CharField(_("list code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("list name"),max_length=const.DB_CHAR_NAME_40)
    module = models.ForeignKey(Module,verbose_name=_("module"),blank=True,null=True)
    status = models.BooleanField(_("in use"),default=True)
    init = models.BooleanField(_("is init"),default=False)
    locked = models.BooleanField(_("is locked"),default=False)
    locked_by = models.ForeignKey(User,verbose_name=_("locked by"),blank=True,null=True)
    lock_time = models.DateTimeField(_("locked time"),null=True,blank=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(ValueList,self).save(force_insert,force_update,using,update_fields)
        sql = 'update basedata_valuelistitem set group_code = %s where groud_id=%s'
        params = [self.code,self.id]
        generic.update(sql,params)

    class Meta:
        verbose_name = _('value list')
        verbose_name_plural = _('value list')


class ValueListItem(models.Model):
    """
    值列表项
    """
    group = models.ForeignKey(ValueList,verbose_name=_("list group"))
    group_code = models.CharField(max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    code = models.CharField(_("item code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("item name"),max_length=const.DB_CHAR_NAME_40)
    status = models.BooleanField(_("in use"),default=True)
    weight = models.IntegerField(_("weight"),null=True,default=9)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if not self.code:
            cnt = self.group.valuelistitem_set.count()+1
            self.code = "%02d" % cnt
        self.group_code = self.group.code
        super(ValueListItem,self).save(force_insert,force_update,using,update_fields)

    def __unicode__(self):
        return "%s-%s" % (self.code,self.name)

    class Meta:
        verbose_name = _('list item')
        verbose_name_plural = _('list item')
        ordering = ['weight','code']
        index_together = ['group','group_code']


def get_value_list(group):
    """

    :param group:
    :return:
    """
    if group:
        return tuple([(item.code, item.name) for item in ValueListItem.objects.filter(group_code__exact=group,status=1)])
    else:
        return None


class Address(generic.BO):
    """
    地址
    """
    ADDRESS_TYPE = get_value_list('S011')
    address_type = models.CharField(_("address type"),max_length=const.DB_CHAR_CODE_2,choices=ADDRESS_TYPE,default='01')
    address = models.CharField(_("address"),max_length=const.DB_CHAR_NAME_120)
    zipcode = models.CharField(_("zipcode"),max_length=const.DB_CHAR_CODE_8,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    contacts = models.CharField(_("contacts"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)

    content_type = models.ForeignKey(ContentType,blank=True,null=True)
    object_id = models.PositiveIntegerField(blank=True,null=True)
    content_object = GenericForeignKey('content_type', 'object_id')

    class Meta:
        verbose_name = _('address')
        verbose_name_plural = _('address')


class Partner(generic.BO):
    """
    合作伙伴
    """
    index_weight = 3
    PARTNER_TYPE = (
        ('C', _('Customer')),
        ('S', _('Supplier')),
    )

    LEVEL = (
        ('A','A'),
        ('B','B'),
        ('C','C'),
        ('D','D'),
    )
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)
    code = models.CharField(_("partner code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    name = models.CharField(_("partner name"),max_length=const.DB_CHAR_NAME_120)
    short = models.CharField(_("short name"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    partner_type = models.CharField(_("type"),max_length=const.DB_CHAR_CODE_2,choices=PARTNER_TYPE,default='C')
    level = models.CharField(_("level"),max_length=const.DB_CHAR_CODE_2,choices=LEVEL,default='C')

    tax_num = models.CharField(_("tax num"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    tax_address = models.CharField(_("tax address"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    tax_account = models.CharField(_("tax account"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)

    contacts = models.CharField(_("contacts"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    memo = models.TextField(_("memo"),blank=True,null=True)

    class Meta:
        verbose_name = _('partner')
        verbose_name_plural = _('partner')
        permissions = (
            ('view_all_customer',_("view all customer")),
            ('view_all_supplier',_("view all supplier")),
        )


class BankAccount(generic.BO):
    """
    银行账户 organization
    """
    account = models.CharField(_("account num"),max_length=const.DB_CHAR_NAME_40)
    title = models.CharField(_("bank name"),max_length=const.DB_CHAR_NAME_40)
    memo = models.CharField(_("memo"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    partner = models.ForeignKey(Partner,verbose_name=_("partner"),blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)

    def __unicode__(self):
        name = ''
        if self.org:
            name = self.org.name
        elif self.partner:
            name = self.partner.name
        return u"%s %s %s" % (name,self.account,self.title)

    class Meta:
        verbose_name = _('bank account')
        verbose_name_plural = _('bank account')


class Project(generic.BO):
    """
    工程项目
    """
    STATUS = get_value_list('S012')
    TYPES = get_value_list('S013')
    index_weight = 1

    code = models.CharField(_("project code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    name = models.CharField(_("project name"),max_length=const.DB_CHAR_NAME_120)
    short = models.CharField(_("short name"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)

    partner = models.ForeignKey(Partner,blank=True,null=True,verbose_name=_("partner"),limit_choices_to={"partner_type":"C"})
    status = models.CharField(_("status"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,default='00',choices=STATUS)
    prj_type = models.CharField(_("project type"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=TYPES,default='00')

    description = models.TextField(_("description"),blank=True,null=True)

    budget = models.DecimalField(_("budget"),max_digits=10,decimal_places=2,blank=True,null=True)
    income = models.DecimalField(_("income"),max_digits=10,decimal_places=2,blank=True,null=True)
    expand = models.DecimalField(_("expand"),max_digits=10,decimal_places=2,blank=True,null=True)

    blueprint = models.FileField(_("blueprint"),upload_to='project',blank=True,null=True)
    offer = models.FileField(_("offer sheet"),upload_to='offer sheet',blank=True,null=True)
    business = models.FileField(_("business document"),upload_to='project',blank=True,null=True)

    users = models.ManyToManyField(User,verbose_name=_("related users"),blank=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)

    class Meta:
        verbose_name = _('project')
        verbose_name_plural = _('project')


class Warehouse(models.Model):
    """
    仓库
    """
    index_weight = 6
    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_40)
    status = models.BooleanField(_("in use"),default=True)
    location = models.CharField(_("location"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    users = models.ManyToManyField(User,verbose_name=_("related users"),blank=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)

    def __unicode__(self):
        return '%s' % self.name

    class Meta:
        verbose_name = _('warehouse')
        verbose_name_plural = _('warehouse')


class Measure(models.Model):
    """
    计量单位
    """
    index_weight = 5
    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_20)
    status = models.BooleanField(_("in use"),default=True)

    def __unicode__(self):
        return '%s' % self.name

    class Meta:
        verbose_name = _('measure')
        verbose_name_plural = _('measure')


class Trade(models.Model):
    """
    国民经济行业分类
    """
    index_weight = 102
    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_6)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_120)
    memo = models.CharField(_("memo"),max_length=const.DB_CHAR_NAME_120,null=True,blank=True)
    parent = models.ForeignKey('self',verbose_name=_("parent"),null=True,blank=True)

    def __unicode__(self):
        return '%s' % self.name

    class Meta:
        verbose_name = _('trade')
        verbose_name_plural = _('trade')
        ordering = ['code']


class Brand(models.Model):
    """
    品牌
    """
    index_weight = 101
    trade = models.ForeignKey(Trade,verbose_name=_("trade"),null=True,blank=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_120)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    weight = models.IntegerField(_("weight"),blank=True,null=True,default=99)

    def __unicode__(self):
        return '%s' % self.name

    class Meta:
        verbose_name = _('brand')
        verbose_name_plural = _('brand')


class Category(models.Model):
    """
    分类
    """
    index_weight = 100
    trade = models.ForeignKey(Trade,verbose_name=_("trade"),null=True,blank=True)
    parent = models.ForeignKey('self',verbose_name=_("parent"),null=True,blank=True)
    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_6,null=True,blank=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_120)
    path = models.CharField(_("path"),max_length=const.DB_CHAR_NAME_200,null=True,blank=True)

    def __unicode__(self):
        return '%s' % self.name

    class Meta:
        verbose_name = _('category')
        verbose_name_plural = _('category')


class TechnicalParameterName(models.Model):
    """
    技术参数-名称，将技术参数绑定于物料分类上，在此分类下的物料自动继承全部技术参数
    """
    index_weight = 7
    category = models.ForeignKey(Category,verbose_name=_("material category"))
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_40)
    status = models.BooleanField(_("in use"),default=True)

    def __unicode__(self):
        return '%s' % self.name

    class Meta:
        verbose_name = _('technical parameter')
        verbose_name_plural = _('technical parameter')


class TechnicalParameterValue(models.Model):
    """
    技术参数-值，将技术参数绑定于物料分类上，在此分类下的物料自动继承全部技术参数
    """
    tech_name = models.ForeignKey(TechnicalParameterName,verbose_name=_("technical name"))
    value = models.CharField(_("value"),max_length=const.DB_CHAR_NAME_80)
    description = models.CharField(_("description"),max_length=const.DB_CHAR_NAME_80,null=True,blank=True)

    def __unicode__(self):
        return '%s' % self.value

    class Meta:
        verbose_name = _('technical value')
        verbose_name_plural = _('technical value')


class Material(generic.BO):
    """
    物料
    """
    index_weight = 4
    code = models.CharField(_("material code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    barcode = models.CharField(_("bar code"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    name = models.CharField(_("material name"),max_length=const.DB_CHAR_NAME_120)
    spec = models.CharField(_("specifications"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    brand = models.ForeignKey(Brand,blank=True,null=True,verbose_name=_("brand"))
    category = models.ForeignKey(Category,blank=True,null=True,verbose_name=_("category"))
    tp = models.CharField(_('mt type'),blank=True,null=True,max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('S054'),default='10')
    status = models.BooleanField(_("in use"),default=True)
    is_equip = models.BooleanField(_("is equipment"),default=False)
    can_sale = models.BooleanField(_("can sale"),default=True)
    is_virtual = models.BooleanField(_("is virtual"),default=False)

    warehouse = models.ForeignKey(Warehouse,blank=True,null=True,verbose_name=_("warehouse"))
    measure = models.ManyToManyField(Measure,verbose_name=_("measure"))

    params = models.ManyToManyField(TechnicalParameterValue,verbose_name=_("technical parameter"),through='MaterialParam')

    stock_price = models.DecimalField(_("stock price"),max_digits=14,decimal_places=4,blank=True,null=True)
    purchase_price = models.DecimalField(_("purchase price"),max_digits=14,decimal_places=4,blank=True,null=True)
    sale_price = models.DecimalField(_("sale price"),max_digits=14,decimal_places=4,blank=True,null=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)

    def __unicode__(self):

        return "%s %s" % (self.code,self.name)

    class Meta:
        verbose_name = _('material')
        verbose_name_plural = _('material')
        ordering = ['tp','code']


class MaterialParam(models.Model):
    """

    """
    material = models.ForeignKey(Material)
    param_value = models.ForeignKey(TechnicalParameterValue)
    param_name = models.ForeignKey(TechnicalParameterName,blank=Trade,null=True)
    creation = models.DateField(auto_now_add=True)

    def __unicode__(self):
        return '%s' % self.param_value

    class Meta:
        verbose_name = _('material parameter')
        verbose_name_plural = _('material parameter')


class ExtraParam(models.Model):
    """

    """
    DATA_TYPE = (
        ('CHAR',_('CHAR')),
        ('NUM',_('NUMBER')),
        ('DATE',_('DATE')),
    )
    material = models.ForeignKey(Material,verbose_name=_("material"))
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_40)
    data_type = models.CharField(_("data type"),default='CHAR',choices=DATA_TYPE,max_length=const.DB_CHAR_CODE_6)
    data_source = models.CharField(_("data source"),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)

    def __unicode__(self):
        return "%s" % self.name

    class Meta:
        verbose_name = _("extra param")
        verbose_name_plural = _("extra params")


class ExpenseAccount(generic.BO):
    """
    费用科目
    """
    CATEGORY = (
        ('HR',_('HR-DOMAIN')),
        ('OF',_('OFFICE-DOMAIN')),
        ('PU',_('PUBLIS-DOMAIN')),
        ('MU',_('MUNADOMAIN')),
        ('BU',_('BUSINESS')),
        ('OT',_('OTHER')),
    )
    index_weight = 10
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_120)
    category = models.CharField(_("category"),max_length=const.DB_CHAR_CODE_4,choices=CATEGORY,default='PU')
    description = models.TextField(_("description"),blank=True,null=True)
    parent = models.ForeignKey('self',verbose_name=_("parent"),null=True,blank=True)
    status = models.BooleanField(_("in use"),default=True)
    org = models.ForeignKey(Organization,verbose_name=_("organization"),blank=True,null=True)

    class Meta:
        verbose_name = _('expenses account')
        verbose_name_plural = _('expenses account')
        ordering = ['category','code']


class Employee(generic.BO):
    """
    职员信息
    """
    index_weight = 2
    code = models.CharField(_("employee number"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    organization = models.ForeignKey(Organization,verbose_name = _('organization'),null=True,blank=True)
    name = models.CharField(_("employee name"),max_length=const.DB_CHAR_NAME_120)
    pinyin = models.CharField(_("pinyin"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    birthday = models.DateField(_("birthday"),blank=True,null=True)

    gender = models.CharField(_("gender"),max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('gender'),default='1')
    idcard = models.CharField(_("id card"),max_length=const.DB_CHAR_NAME_20)

    country = models.CharField(_("nationality"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,default='CN',choices=const.get_value_list('S022'))
    hometown = models.CharField(_("hometown"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    address = models.CharField(_("home address"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    banknum = models.CharField(_("bank account"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    bankname = models.CharField(_("bank name"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    emergency = models.CharField(_("emergency contacts"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    email = models.CharField(_("email"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    office = models.CharField(_("office phone"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)

    position = models.ForeignKey(Position,verbose_name = _('position'))
    rank = models.CharField(_("employee rank"),max_length=const.DB_CHAR_CODE_2,default='00',choices=const.get_value_list('S017'))

    workday = models.DateField(_("workday"),blank=True,null=True)
    startday = models.DateField(_("start date"),blank=True,null=True)

    religion = models.CharField(_("religion"),max_length=const.DB_CHAR_CODE_2,default='00',choices=const.get_value_list('S020'),blank=True,null=True,)
    marital = models.CharField(_("marital status"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S023'),default='10')

    party = models.CharField(_("political party"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S026'),default='13')
    nation = models.CharField(_("nation"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S021'),default='01')

    ygxs = models.CharField(_("employ ygxs"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S019'),default='2')
    status = models.CharField(_("employ status"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S016'),default='10')
    category = models.CharField(_("employ category"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S018'),default='21')

    literacy = models.CharField(_("literacy"),max_length=const.DB_CHAR_CODE_2,default='10',choices=const.get_value_list('S024'),blank=True,null=True)
    major = models.CharField(_("major type"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S038'),default='99')
    degree = models.CharField(_("major degree"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S037'),default='4')

    spjob = models.CharField(_("special job"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S042'),default='00')
    health = models.CharField(_("health"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S043'),default='1')

    tag1 = models.CharField(_("tag1 fzjr"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S039'),default='99')
    tag2 = models.CharField(_("tag2 dwld"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S040'),default='9')
    tag3 = models.CharField(_("tag3 dsjs"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S041'),default='00')
    tag4 = models.CharField(_("tag4 byzk"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S027'),default='0')

    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)

    def age(self):
        import datetime
        if self.birthday:
            cnt = datetime.date.today().year-self.birthday.year
            return cnt

    def work_age(self):
        import datetime
        if self.birthday and self.workday:
            cnt = datetime.date.today().year-self.workday.year
            return cnt

    def __unicode__(self):
        return u'%s %s'%(self.code,self.name)

    age.short_description = u'年龄'
    work_age.short_description = u'工龄'

    class Meta:
        verbose_name = _("employee")
        verbose_name_plural = _("employee")
        permissions = (
            ('view_all_employee',_("view all employee")),
        )


class Family(generic.BO):
    """
    家庭成员
    """
    relation = models.CharField(_("family title"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S025'))
    status = models.CharField(_("social status"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S029'),default='17')
    name = models.CharField(_("name"),max_length=const.DB_CHAR_NAME_60)
    birthday = models.DateField(_("birthday"),blank=True,null=True)
    organization = models.CharField(_("organization"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    phone = models.CharField(_("phone"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    emergency = models.BooleanField(_("emergency"),default=False)
    employee = models.ForeignKey(Employee,verbose_name=_("employee"))

    class Meta:
        verbose_name = _("family member")
        verbose_name_plural = _("family member")


class Education(generic.BO):
    """
    教育履历
    """
    edu_type = models.CharField(_("edu type"),max_length=const.DB_CHAR_CODE_2,choices=const.get_value_list('S035'),default='1')
    school = models.CharField(_("school"),max_length=const.DB_CHAR_NAME_120)
    major = models.CharField(_("major"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    degree = models.CharField(_("major degree"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=const.get_value_list('S037'),default='4')
    employee = models.ForeignKey(Employee,verbose_name=_("employee"))

    class Meta:
        verbose_name = _("education experience")
        verbose_name_plural = _("education experience")


class WorkExperience(generic.BO):
    """
    工作履历
    """
    organization = models.CharField(_("organization"),max_length=const.DB_CHAR_NAME_120)
    position = models.CharField(_("position"),max_length=const.DB_CHAR_NAME_120)
    employee = models.ForeignKey(Employee,verbose_name=_("employee"))

    class Meta:
        verbose_name = _("work experience")
        verbose_name_plural = _("work experience")


class DataImport(generic.BO):

    """
    Data import
    """
    actions = {}

    STATUS = (
        ('0',_('NEW')),
        ('1',_('EXECUTED')),
    )
    imp_date = models.DateField(_('date'),blank=True,null=True,default=datetime.datetime.today)
    title = models.CharField(_('title'),max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_('description'),blank=True,null=True)
    content_type = models.ForeignKey(ContentType,verbose_name=_("content type"),limit_choices_to={"app_label__in":['basedata','organ','auth']})
    attach = models.FileField(_('attach'),blank=True,null=True,upload_to='data')
    is_clear = models.BooleanField(_('clear old data?'),default=0)
    handler = models.CharField(_('handler class'),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    status = models.CharField(_('status'),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)

    def action_import(self,request):
        from django.db import transaction
        if self.attach:
            if self.handler:
                klass = ExcelManager().handlers.get(self.handler)
                with transaction.atomic():
                    klass.handle(self,self.attach)
                    self.status = 1
                    self.save()
            else:
                import xlrd
                import os
                from mis import settings
                path = os.path.join(settings.MEDIA_ROOT,self.attach.name)
                workbook = xlrd.open_workbook(path)
                sheet = workbook.sheet_by_index(0)
                row_count = sheet.nrows
                col_count = sheet.ncols
                cols = []
                with transaction.atomic():
                    for row_index in range(row_count):
                        line = sheet.row_values(row_index)
                        if row_index == 0:
                            cols = line
                            continue
                        elif row_index == 1:
                            continue
                        else:
                            klass = self.content_type.model_class()
                            values = line
                            params = {}
                            for name in cols:
                                index = cols.index(name)
                                v = values[index]
                                if type(v) == str:
                                    v = force_text(v.decode('gbk'))
                                params[name]=v
                                # print 'name is %s value is %s'%(name,v)
                            try:
                                params.pop('')
                            except Exception,e:
                                pass
                            # print params
                            klass.objects.create(**params)
                    self.status = '1'
                    self.save()

    class Meta:
        verbose_name = _("data import")
        verbose_name_plural = _("data import")


class Document(generic.BO):
    """
    文档管理
    """
    TP = (
        ('00',_('SYSTEM MANUAL')),
        ('10',_('BUSINESS DOC')),
    )
    STATUS = (
        ('0',_('draft')),
        ('1',_('published'))
    )
    index_weight = 8
    code = models.CharField(_('code'),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    title = models.CharField(_('title'),max_length=const.DB_CHAR_NAME_120)
    keywords = models.CharField(_('keywords'),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    description = models.TextField(_('description'),blank=True,null=True)
    tp = models.CharField(_('type'),max_length=const.DB_CHAR_CODE_2,default='10',choices=TP)
    business_domain = models.CharField(_("business domain"),max_length=const.DB_CHAR_CODE_4,choices=const.get_value_list('S045'),default='OT')
    user = models.ForeignKey(User,verbose_name=_('user'),blank=True,null=True)
    status = models.CharField(_('status'),max_length=const.DB_CHAR_CODE_2,default='0',choices=STATUS)
    pub_date = models.DateTimeField(_('publish date'),blank=True,null=True)
    size = models.CharField(_('size'),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    attach = models.FileField(_('attach'),blank=True,null=True,upload_to='doc')

    class Meta:
        verbose_name = _("document")
        verbose_name_plural = _("documents")
