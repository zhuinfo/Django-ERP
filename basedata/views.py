# coding=utf-8
from django.contrib.admin import site
from django.http.response import HttpResponseRedirect
from django.utils.encoding import force_text
from django.template.response import TemplateResponse
from django.contrib import messages
from basedata.models import DataImport
from django.utils.translation import ugettext_lazy as _


def action_import(request,object_id):
    """
    数据导入操作
    :param request:
    :param object_id:
    :return:
    """
    title = _("Are you sure?")
    obj = DataImport.objects.get(id=int(object_id))
    opts = obj._meta
    objects_name = force_text(opts.verbose_name)

    if request.POST.get("post"):
        obj.action_import(request)
        try:

            messages.success(request,_('data import successfully'))
        except Exception as e:
            messages.error(request,e)

        return HttpResponseRedirect("/admin/basedata/dataimport/%s"%(object_id))

    context = dict(
        site.each_context(request),
        title=title,
        opts=opts,
        objects_name=objects_name,
        object=obj,
    )
    request.current_app = site.name

    return TemplateResponse(request,'admin/invent/stockin/in_confirmation.html', context)
