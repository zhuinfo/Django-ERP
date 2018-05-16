# coding=utf-8
from django.contrib.admin import site
from django.contrib.contenttypes.models import ContentType
from django.db import connection
from django.http.response import HttpResponseRedirect
from django.utils.encoding import force_text
from django.template.response import TemplateResponse
from django.contrib import messages
from django.utils.translation import ugettext_lazy as _
from django.contrib.contenttypes.models import ContentType


def pay_action(request,model,object_id):
    title = _("Are you sure?")
    ct = ContentType.objects.get(app_label='selfhelp',model=model)
    obj = ct.get_object_for_this_type(id=int(object_id))
    opts = obj._meta
    objects_name = force_text(opts.verbose_name)

    if model == 'reimbursement':
        loan = obj.loan
        amount = obj.logout_amount
        if loan and (amount is None or amount< 0):
            messages.error(request,u'您选择了借款单据，但是未正确填写核销金额，请在\'财务信息\'栏目中更正')
            return HttpResponseRedirect("/admin/selfhelp/%s/%s"%(model,object_id))

    if request.POST.get("post"):
        try:
            obj.action_pay(request)
            messages.success(request,_('action successfully'))
        except Exception as e:
            messages.error(request,e)

        return HttpResponseRedirect("/admin/selfhelp/%s/%s"%(model,object_id))

    context = dict(
        site.each_context(request),
        title=title,
        opts=opts,
        objects_name=objects_name,
        object=obj,
        action_name=_('pay')
    )
    request.current_app = site.name

    return TemplateResponse(request,'admin/invent/stockin/in_confirmation.html', context)
