# created at 15-5-23
# coding=utf-8
__author__ = 'zhugl'

from django.apps import AppConfig
from django.utils.translation import ugettext_lazy as _


class MyAppConfig(AppConfig):
    name = 'invent'
    verbose_name = _("inventory manage")
