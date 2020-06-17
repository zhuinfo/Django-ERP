# coding=utf-8
from django.db import models
from django.db import connection
from django.utils.translation import ugettext_lazy as _
from common import const
from common import generic


class Organization(generic.BO):
    """
    组织机构
    """
    index_weight = 1
    # 组织编号
    code = models.CharField(_("organ code"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 组织名称
    name = models.CharField(_("organ name"), max_length=const.DB_CHAR_NAME_120)
    # 简称
    short = models.CharField(_("short name"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 拼音
    pinyin = models.CharField(_("pinyin"), max_length=const.DB_CHAR_NAME_120, blank=True, null=True)
    # 是否在用？
    status = models.BooleanField(_("in use"), default=True)

    # 纳税识别号
    tax_num = models.CharField(_("tax num"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 开票地址/电话
    tax_address = models.CharField(_("tax address"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 发票开户行
    tax_account = models.CharField(_("tax account"), max_length=const.DB_CHAR_NAME_80, blank=True, null=True)

    # 法人代表
    represent = models.CharField(_("representative "), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 地址
    address = models.CharField(_("address"), max_length=const.DB_CHAR_NAME_120, blank=True, null=True)
    # 邮编
    zipcode = models.CharField(_("zipcode"), max_length=const.DB_CHAR_CODE_8, blank=True, null=True)
    # 传真
    fax = models.CharField(_("fax"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 联系人
    contacts = models.CharField(_("contacts"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 联系电话
    phone = models.CharField(_("phone"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 网址
    website = models.CharField(_("website"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 邮箱
    email = models.CharField(_("email"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 营业执照代码
    lic_code = models.CharField(_("license code"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 组织机构代码
    cer_code = models.CharField(_("certificate code"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 营业执照证书
    license = models.FileField(_("business license"), blank=True, null=True, upload_to='organ')
    # 组织结构证书
    certificate = models.FileField(_("organization code certificate"), blank=True, null=True, upload_to='organ')
    # 排序权重
    weight = models.IntegerField(_("weight"), default=9)

    class Meta:
        verbose_name = _('organization')
        verbose_name_plural = _('organization')


class OrgUnit(generic.BO):
    """
    组织单元
    """
    UNIT_LEVEL = (
        (1, _('BRANCH')),       # 分公司/事业部
        (2, _('DEPARTMENT')),   # 一级部门
        (3, _('OFFICE')),       # 二级部门/处室/科室
        (4, _('TEAM')),         # 组/班
        (5, _('COMMITTEE'))     # 委员会
    )
    index_weight = 2
    # 自关联父级
    parent = models.ForeignKey('self', verbose_name=_("parent"), null=True, blank=True, on_delete=models.CASCADE)
    # 所属组织
    organization = models.ForeignKey(Organization, verbose_name=_('organization'),
                                     null=True, blank=True, on_delete=models.CASCADE)
    # 编号
    code = models.CharField(_("code"), max_length=const.DB_CHAR_CODE_8, blank=True, null=True)
    # 名称
    name = models.CharField(_("name"), max_length=const.DB_CHAR_NAME_120)
    # 简称
    short = models.CharField(_("short name"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 拼音/英文
    pinyin = models.CharField(_("pinyin"), max_length=const.DB_CHAR_NAME_120, blank=True, null=True)
    # 单元类型
    unit_type = models.IntegerField(_("type"), choices=UNIT_LEVEL, default=2)
    # 状态：是否在用
    status = models.BooleanField(_("in use"), default=True)
    # 是否虚拟
    virtual = models.BooleanField(_("is virtual"), default=False)
    # 传真
    fax = models.CharField(_("fax"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 联系电话
    phone = models.CharField(_("phone"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 联系人
    contacts = models.CharField(_("contacts"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 邮箱
    email = models.CharField(_("email"), max_length=const.DB_CHAR_NAME_40, blank=True, null=True)
    # 排序权重
    weight = models.IntegerField(_("weight"), default=99)

    class Meta:
        verbose_name = _('org unit')
        verbose_name_plural = _('org unit')


class Position(generic.BO):
    """
    岗位
    """
    # 未用
    SERIES = (
        ('A', _("Admin Position")),         # 管理行政类
        ('S', _("Sale Position")),          # 市场营销类
        ('T', _("Technology Position")),    # 技术研发类
        ('P', _("Produce Position")),       # 生产操作类
    )

    # 未用：岗位级别
    GRADE = (
        ('01', _("BASIC")),
        ('02', _("MEDIUM")),
        ('03', _("SENIOR")),
        ('04', _("PROFESSOR")),
        ('05', _("EXPERT")),
    )
    index_weight = 3
    # 关联的组织单元
    unit = models.ForeignKey(OrgUnit, verbose_name=_('org unit'), on_delete=models.CASCADE)
    # 关联的组织机构
    organization = models.ForeignKey(Organization, verbose_name=_('organization'),
                                     null=True, blank=True, on_delete=models.CASCADE)
    # 父级
    parent = models.ForeignKey('self', verbose_name=_("parent"), null=True, blank=True, on_delete=models.CASCADE)
    # 编号
    code = models.CharField(_("position code"), max_length=const.DB_CHAR_CODE_8, blank=True, null=True)
    # 岗位名称
    name = models.CharField(_("position name"), max_length=const.DB_CHAR_NAME_120)
    # 简称
    short = models.CharField(_("short name"), max_length=const.DB_CHAR_NAME_20, blank=True, null=True)
    # 拼音/英文
    pinyin = models.CharField(_("pinyin"), max_length=const.DB_CHAR_NAME_120, blank=True, null=True)
    # 岗位序列
    series = models.CharField(_("position series"), max_length=1, default='A', choices=const.get_value_list('S014'))
    # 岗位级别
    grade = models.CharField(
        _("position grade"),
        max_length=const.DB_CHAR_CODE_2,
        default='01',
        choices=const.get_value_list('S015'))
    # 是否虚拟
    virtual = models.BooleanField(_("is virtual"), default=False)
    # 状态：是否在用
    status = models.BooleanField(_("in use"), default=True)
    # 岗位说明
    description = models.TextField(_("position description"), blank=True, null=True)
    # 任职资格
    qualification = models.TextField(_("qualification"), blank=True, null=True)
    # 参考资料
    document = models.FileField(_("reference"), blank=True, null=True)
    # 排序权重
    weight = models.IntegerField(_("weight"), default=99)

    def __unicode__(self):
        return u'%s %s' % (self.code, self.name)

    class Meta:
        verbose_name = _('position')
        verbose_name_plural = _('position')
