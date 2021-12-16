# coding=utf-8
from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from common import const
from common import generic
from common.generic import ToStringMixin


class Site(ToStringMixin, models.Model):
    """
    站点，一个站点下可有多个公司，处于同一个站点下的用户逻辑上位于同一个组织
    """
    index_weight = 1
    begin = models.DateField(_('begin date'), blank=True, null=True)
    end = models.DateField(_('end date'), blank=True, null=True)
    # 站点名称
    name = models.CharField(_('site name'), max_length=const.DB_CHAR_NAME_40)
    # 描述信息
    description = models.TextField(_('site description'), blank=True, null=True)
    user = models.ManyToManyField(User, verbose_name=_('administrator'))

    def __unicode__(self):
        return u'%s' % self.name

    class Meta:
        verbose_name = _('Site')
        verbose_name_plural = _('Site')


class Module(generic.BO):
    """
    模块管理
    """
    index_weight = 2
    # 模块编号
    code = models.CharField(_("module code"), max_length=const.DB_CHAR_CODE_6, blank=True, null=True)
    # 模块名称
    name = models.CharField(_("module name"), max_length=const.DB_CHAR_NAME_40)
    # URL
    url = models.URLField(_("module url"), blank=True, null=True, max_length=const.DB_CHAR_NAME_80)
    # 权重
    weight = models.IntegerField(_("weight"), blank=True, null=True, default=99)
    icon = models.CharField(_("style class"), blank=True, null=True, max_length=const.DB_CHAR_NAME_40)
    # 父级
    parent = models.ForeignKey('self', blank=True, null=True, verbose_name=_("parent"), on_delete=models.CASCADE)
    # 是否在用
    status = models.BooleanField(_("in use"), default=True)

    class Meta:
        verbose_name = _("module")
        verbose_name_plural = _("module")


class Menu(generic.BO):
    """
    菜单管理
    """
    index_weight = 3
    # 关联的模块
    module = models.ForeignKey(Module, verbose_name=_("module"), on_delete=models.CASCADE)
    # 编号
    code = models.CharField(_("menu code"), max_length=const.DB_CHAR_CODE_6, blank=True, null=True)
    # 名称
    name = models.CharField(_("menu name"), max_length=const.DB_CHAR_NAME_40)
    # URL
    url = models.URLField(_("menu url"), blank=True, null=True, max_length=const.DB_CHAR_NAME_80)
    # 权重
    weight = models.IntegerField(_("weight"), blank=True, null=True, default=99)
    icon = models.CharField(_("style class"), blank=True, null=True, max_length=const.DB_CHAR_NAME_40)
    status = models.BooleanField(_("in use"), default=True)

    class Meta:
        verbose_name = _("menu")
        verbose_name_plural = _("menu")


class Role(generic.BO):
    """
    角色管理，分配用户所拥有的菜单
    """
    index_weight = 4
    # 角色编号
    code = models.CharField(_("role code"), max_length=const.DB_CHAR_CODE_6, blank=True, null=True)
    # 角色名称
    name = models.CharField(_("role name"), max_length=const.DB_CHAR_NAME_40)
    # 描述
    description = models.CharField(_("description"), max_length=const.DB_CHAR_NAME_80, blank=True, null=True)
    # 是否在用
    status = models.BooleanField(_("in use"), default=True)
    # 父级角色
    parent = models.ForeignKey('self', blank=True, null=True, verbose_name=_("parent"), on_delete=models.CASCADE)
    users = models.ManyToManyField(User, verbose_name=_("role users"), blank=True)
    menus = models.ManyToManyField(Menu, verbose_name=_("role menus"), blank=True)

    class Meta:
        verbose_name = _("role")
        verbose_name_plural = _("role")
