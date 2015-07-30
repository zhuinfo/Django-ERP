__author__ = 'zhugl'
# created at 15-4-21 
#python import
from threading import local
from django.contrib import admin
from django.apps import apps
from django.conf import settings
from django.contrib.admin import ModelAdmin, actions
from django.contrib.auth import REDIRECT_FIELD_NAME
from django.core.exceptions import ImproperlyConfigured, PermissionDenied
from django.core.urlresolvers import NoReverseMatch, reverse
from django.db.models.base import ModelBase
from django.http import Http404, HttpResponseRedirect
from django.template.engine import Engine
from django.template.response import TemplateResponse
from django.utils import six
from django.utils.text import capfirst
from django.utils.translation import ugettext as _, ugettext_lazy
from django.views.decorators.cache import never_cache
from django.views.decorators.csrf import csrf_protect

_thread_local = local()


def getuser():
    return getattr(_thread_local,'user',None)


class RequestUser(object):

    def process_request(self,request):
        django_user = getattr(request,'user',None)

        if django_user is not None:
            _thread_local.user = django_user

    def process_view(self, request, view_func, view_args, view_kwargs):
        app_weight = {'selfhelp':1,'purchase':3,'sale':2,'invent':4,'organ':5,'basedata':6,'syscfg':7,'workflow':8}
        if view_func.__name__ == 'index':
            app_dict = {}
            for model, model_admin in admin.site._registry.items():
                app_label = model._meta.app_label
                has_module_perms = model_admin.has_module_permission(request)

                if has_module_perms:
                    perms = model_admin.get_model_perms(request)
                    if True in perms.values():
                        info = (app_label, model._meta.model_name)
                        model_dict = {
                            'name': capfirst(model._meta.verbose_name_plural),
                            'object_name': model._meta.object_name,
                            'perms': perms,
                            'weight':getattr(model,'index_weight',99)
                        }
                        if perms.get('change', False):
                            try:
                                model_dict['admin_url'] = reverse('admin:%s_%s_changelist' % info, current_app=admin.site.name)
                            except NoReverseMatch:
                                pass
                        if perms.get('add', False):
                            try:
                                model_dict['add_url'] = reverse('admin:%s_%s_add' % info, current_app=admin.site.name)
                            except NoReverseMatch:
                                pass
                        if app_label in app_dict:
                            app_dict[app_label]['models'].append(model_dict)
                        else:
                            app_dict[app_label] = {
                                'name': apps.get_app_config(app_label).verbose_name,
                                'app_label': app_label,
                                'app_url': reverse(
                                    'admin:app_list',
                                    kwargs={'app_label': app_label},
                                    current_app=admin.site.name,
                                ),
                                'has_module_perms': has_module_perms,
                                'models': [model_dict],
                                'weight':app_weight.get(app_label,99)
                            }

            app_list = list(six.itervalues(app_dict))
            app_list.sort(key=lambda x: x['weight'])

            for app in app_list:
                app['models'].sort(key=lambda x: x['weight'])

            context = dict(
                maxi_app_list=app_list,
            )
            try:
                todolist = self.get_my_task(request)
                context.update(dict(todolist = todolist))
            except Exception,e:
                pass
            # print context
            view_kwargs['extra_context'] = context

        if view_func.__name__ == 'app_index':
            app_label = view_kwargs['app_label']
            app_name = apps.get_app_config(app_label).verbose_name
            app_dict = {}
            lib_dict = {}
            for model, model_admin in admin.site._registry.items():
                if model_admin.has_module_permission(request):
                    label = model._meta.app_label
                    is_current = False
                    if label == app_label:
                        is_current = True
                    lib_dict[label] = {
                        'name': apps.get_app_config(label).verbose_name,
                        'app_label': label,
                        'app_url': reverse(
                        'admin:app_list',
                            kwargs={'app_label': label},
                            current_app=admin.site.name,
                            ),
                        'weight':app_weight.get(label,99),
                        'is_current':is_current,
                    }
                if app_label == model._meta.app_label:
                    has_module_perms = model_admin.has_module_permission(request)
                    if not has_module_perms:
                        raise PermissionDenied

                    perms = model_admin.get_model_perms(request)

                    if True in perms.values():
                        info = (app_label, model._meta.model_name)
                        model_dict = {
                            'name': capfirst(model._meta.verbose_name_plural),
                            'object_name': model._meta.object_name,
                            'perms': perms,
                            'weight':getattr(model,'index_weight',99)
                        }
                        if perms.get('change'):
                            try:
                                model_dict['admin_url'] = reverse('admin:%s_%s_changelist' % info, current_app=admin.site.name)
                            except NoReverseMatch:
                                pass
                        if perms.get('add'):
                            try:
                                model_dict['add_url'] = reverse('admin:%s_%s_add' % info, current_app=admin.site.name)
                            except NoReverseMatch:
                                pass
                        if app_dict:
                            app_dict['models'].append(model_dict),
                        else:
                            app_dict = {
                                'name': app_name,
                                'app_label': app_label,
                                'app_url': '',
                                'has_module_perms': has_module_perms,
                                'models': [model_dict],
                            }
            if not app_dict:
                raise Http404('The requested admin page does not exist.')
            # Sort the models alphabetically within each app.
            app_dict['models'].sort(key=lambda x: x['weight'])

            app_lib = list(six.itervalues(lib_dict))
            app_lib.sort(key=lambda x: x['weight'])

            context = dict(
                maxi_app_list=[app_dict],
                app_lib=app_lib,
            )
            view_kwargs['extra_context'] = context

    def get_my_task(self,request):
        from workflow.models import TodoList
        if request and request.user:
            query = TodoList.objects.filter(user=request.user,status=0)
            if query.count() == 0:
                return None
            else:
                return query.all()[:10]
