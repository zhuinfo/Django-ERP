# coding=utf-8
__author__ = 'zhugl'
# created at 15-4-21
import datetime
import xlwt
import re
from django.db import models
from django.db import connection,transaction
from django.db.models import fields
from django.db.models.fields import related
from django.contrib import admin
from django.http import HttpRequest,HttpResponseRedirect,HttpResponse
from django.contrib.contenttypes.models import ContentType
from django.utils.text import force_text
from django.utils.encoding import smart_str
from django.utils.http import urlquote
from django.utils.translation import ugettext_lazy as _
from common import const
from midware import cuser


def update(sql, params=None):
    """
    :param sql:
    :param params:
    :return:
    """
    cursor = connection.cursor()
    with transaction.atomic():
        try:
            if params:
                cursor.execute(sql,params)
            else:
                cursor.execute(sql)
        except Exception,e:
            print e

def get_app_model_info_from_request(request):
    """

    """
    if request and isinstance(request,HttpRequest):
        import re
        pattern = re.compile(r"/(admin)/(\w+)/(\w+)/(\d+)")
        match = pattern.match(request.path)

        if match and match.group():
            app = match.group(2)
            model = match.group(3)
            oid = match.group(4)
            ct = ContentType.objects.get(app_label=app,model=model)
            obj = ct.get_object_for_this_type(id=oid)
            return {'app':app,'model':model,'id':oid,'obj':obj}
    return None


class MineBOManager(models.Manager):
    """
    get the objects created by current login user
    """
    def get_query_set(self):
        return super(MineBOManager,self).get_query_set().filter(creator=cuser.getuser())


class BOManager(models.Manager):
    """
    """
    def get_query_set(self):
        return super(BOManager,self).get_query_set()


class BO(models.Model):
    """
    All business object derive from this class
    """
    begin = models.DateField(_('begin date'),blank=True,null=True)
    end = models.DateField(_('end date'),blank=True,null=True)
    creator = models.CharField(_("creator"),blank=True,null=True,max_length=const.DB_CHAR_NAME_20)
    modifier = models.CharField(_("modifier"),blank=True,null=True,max_length=const.DB_CHAR_NAME_20)
    creation = models.DateTimeField(_('creation'),auto_now_add=True,blank=True,null=True)
    modification = models.DateTimeField(_('modification'),auto_now=True,blank=True,null=True)
    # mine = MineBOManager()
    objects = models.Manager()

    def __unicode__(self):
        display = getattr(self,'name',None) or getattr(self,'title',None) or getattr(self,'description',None)
        if not display:
            display = ' '
        return u'%s' % display

    class Meta:
        abstract = True


class BOAdmin(admin.ModelAdmin):
    """
    All business object admin derive from this class
    """
    CODE_NUMBER_WIDTH = 4
    CODE_PREFIX = '9'
    extra_buttons = []

    exclude = ['creator','modifier','creation','modification','begin','end']
    list_per_page = 18
    actions = ['export_selected_data']

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        """

        :param request:
        :param object_id:
        :param form_url:
        :param extra_context:
        :return:
        """
        app_info = get_app_model_info_from_request(request)
        workflow_modal = None
        workflow_instance = None
        has_workflow_modal = False
        has_workflow_instance = False
        show_workflow_line = False
        show_submit_button = False
        can_restart = False
        can_edit = False
        # print app_info
        if app_info:
            try:
                modal = ContentType.objects.get(app_label='workflow',model='modal')
                workflow_modal = modal.get_object_for_this_type(app_name=app_info['app'],model_name=app_info['model'])
                has_workflow_modal = True
                # print workflow_modal.code
                instance = ContentType.objects.get(app_label='workflow',model='instance')
                workflow_instance = instance.get_object_for_this_type(modal=workflow_modal,object_id=app_info['id'])
                has_workflow_instance = True
                todo = ContentType.objects.get(app_label='workflow',model='todolist')
                todo_list = todo.model_class().objects.filter(inst=workflow_instance,status=0,user=request.user)
                x = todo_list.all()

                if x and len(x)>0:
                    can_edit = x[0].node.can_edit
                if todo_list.count() > 0:
                    # print 'we fount it'
                    unread = todo_list.filter(is_read=0)
                    show_workflow_line = True
                    if unread.count() > 0:
                        unread.update(is_read=1,read_time=datetime.datetime.now())
                if workflow_instance.status == 3 and request.user == workflow_instance.starter:
                    can_restart = True
                    show_workflow_line = True

            except Exception,e:
                print Exception,e

        if workflow_modal and not workflow_instance:
            show_submit_button = True
        extra_context = extra_context or {}
        ctx = dict(
            has_workflow_instance = has_workflow_instance,
            has_workflow_modal = has_workflow_modal,
            workflow_modal = workflow_modal,
            workflow_instance = workflow_instance,
            show_workflow_line = show_workflow_line,
            can_restart = can_restart,
            can_edit = can_edit,
            show_submit_button = show_submit_button,
        )
        if len(self.extra_buttons) > 0:
            buttons = dict(
                extra_buttons = self.extra_buttons
            )
            ctx.update(buttons)
        extra_context.update(ctx)
        # print extra_context
        return super(BOAdmin,self).changeform_view(request,object_id,form_url,extra_context)

    def history_view(self, request, object_id, extra_context=None):
        """

        :param request:
        :param object_id:
        :param extra_context:
        :return:
        """
        app_info = get_app_model_info_from_request(request)
        # print app_info
        if app_info:
            try:
                modal = ContentType.objects.get(app_label='workflow',model='modal')
                workflow_modal = modal.get_object_for_this_type(app_name=app_info['app'],model_name=app_info['model'])
                has_workflow_modal = True
                instance = ContentType.objects.get(app_label='workflow',model='instance')
                workflow_instance = instance.get_object_for_this_type(modal=workflow_modal,object_id=app_info['id'])
                has_workflow_instance = True
                history = ContentType.objects.get(app_label='workflow',model='history')
                history_list = history.model_class().objects.filter(inst=workflow_instance)
                has_history = True
                todo = ContentType.objects.get(app_label='workflow',model='todolist')
                todo_list = todo.model_class().objects.filter(inst=workflow_instance,status=0).exclude(node=None)

                extra_context = extra_context or {}
                ctx = dict(
                    has_workflow_instance = has_workflow_instance,
                    has_workflow_modal = has_workflow_modal,
                    workflow_modal = workflow_modal,
                    workflow_instance = workflow_instance,
                    history_list = history_list,
                    has_history = has_history,
                    todo_list = todo_list,
                )
                # print history_list
                extra_context.update(ctx)
            except Exception,e:
                print Exception,e
                pass
        return super(BOAdmin,self).history_view(request,object_id,extra_context)

    def get_changeform_initial_data(self, request):
        import datetime
        return {'begin':datetime.date.today,'end':datetime.date(9999,12,31)}

    def save_model(self, request, obj, form, change):

        if change:
            setattr(obj,'modifier',request.user.username)
        else:
            setattr(obj,'creator',request.user.username)
            setattr(obj,'begin',datetime.date.today())
            setattr(obj,'end',datetime.date(9999,12,31))
            try:
                setattr(obj,'user',request.user)
            except Exception,e:
                pass

        super(BOAdmin,self).save_model(request,obj,form,change)
        # print '=========it is here========='
        try:
            code = getattr(obj,'code')
            # print code
            if code is None or len(code) == 0:
                fmt = '%s%0'+str(self.CODE_NUMBER_WIDTH)+'d'
                code = fmt % (self.CODE_PREFIX,obj.id)
                table = obj._meta.db_table
                sql = 'update %s set code = \'%s\' where id=%s' % (table,code,obj.id)
                print sql
                update(sql)
        except Exception,e:
            print e

    # def response_change(self, request, obj):
        # return HttpResponseRedirect('')

    def export_selected_data(self,request,queryset):
        ops = self.model._meta
        workbook = xlwt.Workbook(encoding='utf-8')
        dd = datetime.date.today().strftime('%Y%m%d')
        file_name = force_text(ops.verbose_name+dd)
        sheet = workbook.add_sheet(force_text(ops.verbose_name))
        obj_fields = getattr(self,'export_fields',None) or self.list_display or self.fields

        head_col_index = 0
        for field in obj_fields:
            col_name = field
            try:
                f = ops.get_field(field)
                col_name = f.verbose_name
            except Exception,e:
                f = getattr(self.model,field)
                if hasattr(f,'short_description'):
                    col_name = f.short_description
            sheet.write(0,head_col_index,force_text(col_name))
            head_col_index+=1
        row_index = 1
        for obj in queryset:
            col_index = 0
            for field in obj_fields:
                f = field
                try:
                    f = ops.get_field(field)
                except Exception,e:
                    pass
                v = getattr(obj,field,'')
                if hasattr(v,'__call__') or callable(v):
                    v = v()
                elif type(f) == fields.DateField:
                    v = v.strftime('%Y-%m-%d')
                elif type(f) == fields.DateTimeField:
                    v = v.strftime('%Y-%m-%d %H:%M')
                elif type(f) == fields.CharField and f.choices:
                    fc = 'get_'+field+'_display'
                    v = getattr(obj,fc)()
                elif type(f) == related.ForeignKey:
                    v = str(v)
                sheet.write(row_index,col_index,v)
                col_index += 1
            row_index += 1
        response = HttpResponse(content_type='application/vnd.ms-excel')
        agent = request.META.get('HTTP_USER_AGENT')
        nn = smart_str(file_name)
        if agent and re.search('MSIE',agent):
            nn = urlquote(file_name)
        response['Content-Disposition'] = 'attachment; filename=%s.xls'%nn
        workbook.save(response)
        return response
        #self.message_user(request,'SUCCESS')
    export_selected_data.short_description = _("export selected %(verbose_name_plural)s")

    class Meta:
        ordering = ['-creation']

    class Media:
        css = {'all':('css/maximus.css',)}
        js = ('js/maximus.js',)
