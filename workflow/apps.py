__author__ = 'zhugl'
# created at 15-4-22 
from django.apps.config import AppConfig
from django.utils.translation import ugettext_lazy as _


class WorkflowConfig(AppConfig):
    name = 'workflow'
    verbose_name = _('workflow')