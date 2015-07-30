# coding=utf-8
from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from common import const
from common import generic


class Site(models.Model):
    """
    站点，一个站点下可有多个公司，处于同一个站点下的用户逻辑上位于同一个组织
    """
    index_weight = 1
    begin = models.DateField(_('begin date'), blank=True,null=True)
    end = models.DateField(_('end date'), blank=True,null=True)
    name = models.CharField(_('site name'), max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_('site description'),blank=True,null=True)
    user = models.ManyToManyField(User,verbose_name=_('administrator'))

    def __unicode__(self):
        return u'%s'%self.name

    class Meta:
        verbose_name = _('Site')
        verbose_name_plural = _('Site')


class Module(generic.BO):
    """
    模块管理
    """
    index_weight = 2
    code = models.CharField(_("module code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("module name"),max_length=const.DB_CHAR_NAME_40)
    url = models.URLField(_("module url"),blank=True,null=True,max_length=const.DB_CHAR_NAME_80)
    weight = models.IntegerField(_("weight"),blank=True,null=True,default=99)
    icon = models.CharField(_("style class"),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)
    parent = models.ForeignKey('self',blank=True,null=True,verbose_name=_("parent"))
    status = models.BooleanField(_("in use"),default=True)

    class Meta:
        verbose_name = _("module")
        verbose_name_plural = _("module")


class Menu(generic.BO):
    """
    菜单管理
    """
    index_weight = 3
    module = models.ForeignKey(Module,verbose_name=_("module"))
    code = models.CharField(_("menu code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("menu name"),max_length=const.DB_CHAR_NAME_40)
    url = models.URLField(_("menu url"),blank=True,null=True,max_length=const.DB_CHAR_NAME_80)
    weight = models.IntegerField(_("weight"),blank=True,null=True,default=99)
    icon = models.CharField(_("style class"),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)
    status = models.BooleanField(_("in use"),default=True)

    class Meta:
        verbose_name = _("menu")
        verbose_name_plural = _("menu")


class Role(generic.BO):
    """
    角色管理，分配用户所拥有的菜单
    """
    index_weight = 4
    code = models.CharField(_("role code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("role name"),max_length=const.DB_CHAR_NAME_40)
    description = models.CharField(_("description"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    status = models.BooleanField(_("in use"),default=True)
    parent = models.ForeignKey('self',blank=True,null=True,verbose_name=_("parent"))
    users = models.ManyToManyField(User,verbose_name=_("role users"),blank=True)
    menus = models.ManyToManyField(Menu,verbose_name=_("role menus"),blank=True)

    class Meta:
        verbose_name = _("role")
        verbose_name_plural = _("role")
