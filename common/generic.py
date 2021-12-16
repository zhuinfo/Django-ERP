# coding=utf-8
import logging

__author__ = 'zhugl'
# created at 15-4-21
import datetime
import xlwt
import re
from django.db import models
from django.db import connection, transaction
from django.db.models import fields
from django.db.models.fields import related
from django.contrib import admin
from django.http import HttpRequest, HttpResponse
from django.contrib.contenttypes.models import ContentType
from django.utils.encoding import smart_str, force_text, force_str
from django.utils.http import urlquote
from django.utils.translation import ugettext_lazy as _
from common import const
from midware import cuser


def update(sql, params=None):
    """ 执行SQL

    :param sql: str, SQL语句
    :param params: list,参数

    :return:
    """
    cursor = connection.cursor()
    with transaction.atomic():
        try:
            if params:
                cursor.execute(sql, params)
            else:
                cursor.execute(sql)
        except Exception as e:
            logging.error('', exc_info=e)


def get_app_model_info_from_request(request):
    """ 从请求中获取app模型信息

    :param request: django.http.HttpRequest

    :return: dict or None
    """
    if request and isinstance(request, HttpRequest):
        import re
        # 匹配请求路径
        pattern = re.compile(r"/(admin)/(\w+)/(\w+)/(\d+)")
        match = pattern.match(request.path)

        if match and match.group():
            app = match.group(2)  # 第2个括号？
            model = match.group(3)  # 第3个括号？
            oid = match.group(4)  # 第4个括号？
            # 获取 ContentType 对象
            ct = ContentType.objects.get(app_label=app, model=model)
            obj = ct.get_object_for_this_type(id=oid)
            return {'app': app, 'model': model, 'id': oid, 'obj': obj}
    return None


class MineBOManager(models.Manager):
    """
    get the objects created by current login user
    """

    def get_query_set(self):
        # cuser.getuser(): 获取当前用户
        return super(MineBOManager, self).get_query_set().filter(creator=cuser.getuser())


class BOManager(models.Manager):
    """
    """

    def get_query_set(self):
        return super(BOManager, self).get_query_set()


class ToStringMixin(object):

    def __str__(self):
        if hasattr(self, '__unicode__'):
            return force_str(self.__unicode__())
        else:
            return super(ToStringMixin, self).__str__()


class BO(ToStringMixin, models.Model):
    """
    All business object derive from this class

    通用事务对象抽象类
    """
    # 开始日期
    begin = models.DateField(_('begin date'), blank=True, null=True)
    # 结束日期
    end = models.DateField(_('end date'), blank=True, null=True)
    # 创建者
    creator = models.CharField(_("creator"), blank=True, null=True, max_length=const.DB_CHAR_NAME_20)
    # 修改者
    modifier = models.CharField(_("modifier"), blank=True, null=True, max_length=const.DB_CHAR_NAME_20)
    # 创建datetime
    creation = models.DateTimeField(_('creation'), auto_now_add=True, blank=True, null=True)
    # 修改datetime
    modification = models.DateTimeField(_('modification'), auto_now=True, blank=True, null=True)

    # mine = MineBOManager()
    objects = models.Manager()

    def __unicode__(self):
        display = getattr(self, 'name', None) or getattr(self, 'title', None) or getattr(self, 'description', None)
        if not display:
            display = ' '
        return u'%s' % display

    class Meta:
        abstract = True


class BOAdmin(admin.ModelAdmin):
    """
    All business object admin derive from this class
    """
    # 编码的数字长度
    CODE_NUMBER_WIDTH = 4
    # 编码前缀
    CODE_PREFIX = '9'
    # 额外的按钮
    extra_buttons = []

    exclude = ['creator', 'modifier', 'creation', 'modification', 'begin', 'end']
    list_per_page = 18
    actions = ['export_selected_data']

    def changeform_view(self, request, object_id=None, form_url='', extra_context=None):
        """修改表单视图

        :param request:
        :param object_id:
        :param form_url:
        :param extra_context:
        :return:
        """
        app_info = get_app_model_info_from_request(request)
        # 工作流
        workflow_modal = None
        workflow_instance = None
        has_workflow_modal = False
        has_workflow_instance = False

        show_workflow_line = False
        # 显示提交按钮
        show_submit_button = False
        # 可以重启
        can_restart = False
        # 可以编辑
        can_edit = False

        # print app_info
        if app_info:
            try:
                modal = ContentType.objects.get(app_label='workflow', model='modal')
                workflow_modal = modal.get_object_for_this_type(app_name=app_info['app'], model_name=app_info['model'])
                has_workflow_modal = True
                # print workflow_modal.code
                instance = ContentType.objects.get(app_label='workflow', model='instance')
                workflow_instance = instance.get_object_for_this_type(modal=workflow_modal, object_id=app_info['id'])
                has_workflow_instance = True
                todo = ContentType.objects.get(app_label='workflow', model='todolist')
                todo_list = todo.model_class().objects.filter(inst=workflow_instance, status=0, user=request.user)
                x = todo_list.all()

                if x and len(x) > 0:
                    can_edit = x[0].node.can_edit
                if todo_list.count() > 0:
                    # print 'we fount it'
                    unread = todo_list.filter(is_read=0)
                    show_workflow_line = True
                    if unread.count() > 0:
                        unread.update(is_read=1, read_time=datetime.datetime.now())
                # 工作流实例已经被拒绝（DENY） 并且当前用户是发起人
                if workflow_instance.status == 3 and request.user == workflow_instance.starter:
                    can_restart = True
                    show_workflow_line = True

            except Exception:
                pass

        if workflow_modal and not workflow_instance:
            show_submit_button = True

        # 更新额外的内容
        extra_context = extra_context or {}
        ctx = dict(
            has_workflow_instance=has_workflow_instance,
            has_workflow_modal=has_workflow_modal,
            workflow_modal=workflow_modal,
            workflow_instance=workflow_instance,
            show_workflow_line=show_workflow_line,
            can_restart=can_restart,
            can_edit=can_edit,
            show_submit_button=show_submit_button,
        )
        # 添加额外的按钮
        if len(self.extra_buttons) > 0:
            buttons = dict(
                extra_buttons=self.extra_buttons
            )
            ctx.update(buttons)
        extra_context.update(ctx)
        # print extra_context
        return super(BOAdmin, self).changeform_view(request, object_id, form_url, extra_context)

    def history_view(self, request, object_id, extra_context=None):
        """ 历史记录视图

        :param request:
        :param object_id:
        :param extra_context:
        :return:
        """
        app_info = get_app_model_info_from_request(request)
        # print app_info
        if app_info:
            try:
                # 工作流
                modal = ContentType.objects.get(app_label='workflow', model='modal')
                workflow_modal = modal.get_object_for_this_type(app_name=app_info['app'], model_name=app_info['model'])
                has_workflow_modal = True
                
                # 工作流实例
                instance = ContentType.objects.get(app_label='workflow', model='instance')
                workflow_instance = instance.get_object_for_this_type(modal=workflow_modal, object_id=app_info['id'])
                has_workflow_instance = True
                
                # 审批历史
                history = ContentType.objects.get(app_label='workflow', model='history')
                history_list = history.model_class().objects.filter(inst=workflow_instance)
                has_history = True

                # 代办事项
                todo = ContentType.objects.get(app_label='workflow', model='todolist')
                todo_list = todo.model_class().objects.filter(inst=workflow_instance, status=0).exclude(node=None)

                extra_context = extra_context or {}
                ctx = dict(
                    has_workflow_instance=has_workflow_instance,
                    has_workflow_modal=has_workflow_modal,
                    workflow_modal=workflow_modal,
                    workflow_instance=workflow_instance,
                    history_list=history_list,
                    has_history=has_history,
                    todo_list=todo_list,
                )
                # print history_list
                extra_context.update(ctx)
            except Exception:
                pass
        return super(BOAdmin, self).history_view(request, object_id, extra_context)

    def get_changeform_initial_data(self, request):
        """获取修改表单的初始数据

        https://docs.djangoproject.com/en/3.0/ref/contrib/admin/#django.contrib.admin.ModelAdmin.get_changeform_initial_data
        """
        import datetime
        return {'begin': datetime.date.today, 'end': datetime.date(9999, 12, 31)}

    def save_model(self, request, obj, form, change):

        if change:
            # 修改时更新以下信息
            setattr(obj, 'modifier', request.user.username)
        else:
            # 创建时更新以下信息
            setattr(obj, 'creator', request.user.username)
            setattr(obj, 'begin', datetime.date.today())
            setattr(obj, 'end', datetime.date(9999, 12, 31))
            try:
                setattr(obj, 'user', request.user)
            except Exception:
                pass

        super(BOAdmin, self).save_model(request, obj, form, change)
        # print '=========it is here========='

        # 更新 obj.code
        try:
            code = getattr(obj, 'code')
            # print code
            if code is None or len(code) == 0:
                # 生成格式化
                fmt = '%s%0' + str(self.CODE_NUMBER_WIDTH) + 'd'
                # 生成code，这里需要获取obj的id
                code = fmt % (self.CODE_PREFIX, obj.id)
                # 获取数据表名称
                table = obj._meta.db_table
                # 生成SQL
                sql = 'update %s set code = \'%s\' where id=%s' % (table, code, obj.id)
                # 执行SQL
                update(sql)
        except Exception:
            # 如果没有 code 字段则会进入异常分支
            pass

    # def response_change(self, request, obj):
        # return HttpResponseRedirect('')

    def export_selected_data(self, request, queryset):
        """导出所选的数据"""
        ops = self.model._meta
        workbook = xlwt.Workbook(encoding='utf-8')
        dd = datetime.date.today().strftime('%Y%m%d')
        file_name = force_text(ops.verbose_name + dd)
        sheet = workbook.add_sheet(force_text(ops.verbose_name))
        obj_fields = getattr(self, 'export_fields', None) or self.list_display or self.fields

        head_col_index = 0
        for field in obj_fields:
            col_name = field
            try:
                f = ops.get_field(field)
                col_name = f.verbose_name
            except Exception:
                f = getattr(self.model, field)
                if hasattr(f, 'short_description'):
                    col_name = f.short_description
            sheet.write(0, head_col_index, force_text(col_name))
            head_col_index += 1
        row_index = 1
        for obj in queryset:
            col_index = 0
            for field in obj_fields:
                f = field
                try:
                    f = ops.get_field(field)
                except Exception:
                    pass
                v = getattr(obj, field, '')
                if hasattr(v, '__call__') or callable(v):
                    v = v()
                elif isinstance(f, fields.DateField):
                    v = v.strftime('%Y-%m-%d')
                elif isinstance(f, fields.DateTimeField):
                    v = v.strftime('%Y-%m-%d %H:%M')
                elif isinstance(f, fields.CharField) and f.choices:
                    fc = 'get_' + field + '_display'
                    v = getattr(obj, fc)()
                elif isinstance(f, related.ForeignKey):
                    v = str(v)
                sheet.write(row_index, col_index, v)
                col_index += 1
            row_index += 1
        response = HttpResponse(content_type='application/vnd.ms-excel')
        agent = request.META.get('HTTP_USER_AGENT')
        nn = smart_str(file_name)
        if agent and re.search('MSIE', agent):
            nn = urlquote(file_name)
        response['Content-Disposition'] = 'attachment; filename=%s.xls' % nn
        workbook.save(response)
        return response
        # self.message_user(request,'SUCCESS')
    export_selected_data.short_description = _("export selected %(verbose_name_plural)s")

    class Meta:
        # 默认按创建时间降序排序
        ordering = ['-creation']

    class Media:
        # 额外的前端静态文件？
        css = {'all': ('css/maximus.css',)}
        js = ('js/maximus.js',)
