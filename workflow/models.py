# coding=utf-8
from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.auth.models import User
from django.utils.html import format_html
from django.utils.translation import ugettext_lazy as _
from common import const
from syscfg.models import Role
from organ.models import Position,OrgUnit


class Modal(models.Model):
    """

    """
    import datetime
    index_weight = 1
    code = models.CharField(_("workflow code"),max_length=const.DB_CHAR_CODE_6,blank=True,null=True)
    name = models.CharField(_("workflow name"),max_length=const.DB_CHAR_NAME_40)
    description = models.TextField(_("description"),blank=True,null=True)
    content_type = models.ForeignKey(ContentType,verbose_name=_("content type"),limit_choices_to={"app_label__in":['basedata','organ']})
    app_name = models.CharField(_("app name"),max_length=const.DB_CHAR_NAME_60,blank=True,null=True)
    model_name = models.CharField(_("model name"),max_length=const.DB_CHAR_NAME_60,blank=True,null=True)
    # added by zhugl 2015-05-10
    begin = models.DateField(_("begin date"),blank=True,null=True,default=datetime.date.today)
    end = models.DateField(_("end date"),blank=True,null=True,default=datetime.date(9999,12,31))

    def __unicode__(self):
        return "%s" % self.name

    class Meta:
        verbose_name = _("workflow model")
        verbose_name_plural = _("workflow model")


class Node(models.Model):
    """
    submitter()
    upper()
    user()
    role()
    position()
    sql()
    etc:upper('zhangsan','lisi')
    """
    HANDLER_TYPE = (
        (1, _("designated user")),
        (2, _("designated position")),
        (3, _("designated role")),
        (4, _("submitter")),
    )
    index_weight = 2
    modal = models.ForeignKey(Modal,verbose_name=_("workflow model"))
    code = models.CharField(_("node code"),max_length=const.DB_CHAR_CODE_4,blank=True,null=True)
    name = models.CharField(_("node name"),max_length=const.DB_CHAR_NAME_80)
    tooltip = models.CharField(_('tooltip words'),blank=True,null=True,max_length=const.DB_CHAR_NAME_120)

    start = models.BooleanField(_("start node"),default=False)
    stop = models.BooleanField(_("stop node"),default=False)
    can_terminate = models.BooleanField(_("can terminate"),default=False)
    can_deny = models.BooleanField(_("can deny"),default=True)
    can_edit = models.BooleanField(_("can edit"),default=False)

    email_notice = models.BooleanField(_("email notice"),default=True)
    short_message_notice = models.BooleanField(_("short message notice"),default=False)
    approve_node = models.BooleanField(_("approve node"),default=False)
    handler = models.TextField(_("handler"),blank=True,null=True,help_text=u'自定义SQL语句，优先高于指定用户、岗位、角色')
    # added by zhugl 2015-05-10
    handler_type = models.IntegerField(_("handler type"),choices=HANDLER_TYPE,default=1)
    positions = models.ManyToManyField(Position,verbose_name=_("designated position"),blank=True)
    roles = models.ManyToManyField(Role,verbose_name=_("designated role"),blank=True)
    users = models.ManyToManyField(User,verbose_name=_("designated user"),blank=True)
    departments = models.ManyToManyField(OrgUnit,verbose_name=_("designated department"),blank=True)
    next = models.ManyToManyField('self',blank=True,verbose_name=_("next node"),symmetrical=False)
    # added by zhugl 2015-06-30
    next_user_handler = models.CharField(_('next user handler'),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)
    next_node_handler = models.CharField(_('next node handler'),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)
    status_field = models.CharField(_('status field'),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)
    status_value = models.CharField(_('status value'),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)
    action = models.CharField(_('execute action'),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        if not self.code:
            fmt = 'N%02d'
            self.code = fmt % (self.modal.node_set.count()+1)
        super(Node,self).save(force_insert,force_update,using,update_fields)

    def __unicode__(self):
        return "%s-%s" % (self.code, self.name)

    class Meta:
        verbose_name = _("workflow node")
        verbose_name_plural = _("workflow node")


class Instance(models.Model):
    """

    """
    STATUS = (
        (1, _("NEW")),
        (2, _("IN PROGRESS")),
        (3, _("DENY")),
        (4, _("TERMINATED")),
        (9, _("APPROVED")),
        (99, _("COMPLETED"))
    )
    index_weight = 3
    code = models.CharField(_("code"),blank=True,null=True,max_length=const.DB_CHAR_CODE_10)
    modal = models.ForeignKey(Modal,verbose_name=_("workflow model"))
    object_id = models.PositiveIntegerField("object id")
    starter = models.ForeignKey(User,verbose_name=_("start user"),related_name="starter")
    start_time = models.DateTimeField(_("start time"),auto_now_add=True)
    approved_time = models.DateTimeField(_("approved time"),blank=True,null=True)
    status = models.IntegerField(_("status"),default=1,choices=STATUS)
    current_nodes = models.ManyToManyField(Node,verbose_name=_("current node"),blank=True)

    def __unicode__(self):
        return '%s' % self.code

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(Instance,self).save(force_insert,force_update,using,update_fields)
        if not self.code:
            self.code = 'S%05d'%self.id
            self.save()

    class Meta:
        verbose_name = _("workflow instance")
        verbose_name_plural = _("workflow instance")


class History(models.Model):
    """
    workflow history
    """
    PROCESS_TYPE = (
        (0, _("SUBMIT")),
        (1, _("AGREE")),
        (3, _("DENY")),
        (4, _("TERMINATE")),
    )
    index_weight = 5
    inst = models.ForeignKey(Instance,verbose_name=_("workflow instance"))
    node = models.ForeignKey(Node,verbose_name=_("workflow node"),blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("submitter"))
    pro_time = models.DateTimeField(_("process time"),auto_now_add=True)
    pro_type = models.IntegerField(_("process type"),choices=PROCESS_TYPE,default=0)
    memo = models.CharField(_("memo"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)

    def get_node_desc(self):
        if self.node:
            return self.node.name
        else:
            return u'启动'

    def get_action_desc(self):
        action_mapping = {0:u'提交',1:u'同意',3:u'拒绝',4:u'终止',}
        # print action_mapping
        if self.pro_type:
            return action_mapping[self.pro_type]
        else:
            return u'提交'

    def get_memo_desc(self):
        if self.memo:
            return self.memo
        else:
            return ''

    class Meta:
        verbose_name = _("workflow history")
        verbose_name_plural = _("workflow history")
        ordering = ['inst','pro_time']


class TodoList(models.Model):
    """

    """
    index_weight = 4
    code = models.CharField(_("code"),max_length=const.DB_CHAR_CODE_10,blank=True,null=True)
    inst = models.ForeignKey(Instance,verbose_name=_("workflow instance"))
    node = models.ForeignKey(Node,verbose_name=_("current node"),blank=True,null=True)
    app_name = models.CharField(_("app name"),max_length=const.DB_CHAR_NAME_60,blank=True,null=True)
    model_name = models.CharField(_("model name"),max_length=const.DB_CHAR_NAME_60,blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("handler"))
    arrived_time = models.DateTimeField(_("arrived time"),auto_now_add=True)
    is_read = models.BooleanField(_("is read"),default=False)
    read_time = models.DateTimeField(_("read time"),blank=True,null=True)
    status = models.BooleanField(_("is done"),default=False)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(TodoList,self).save(force_update,force_update,using,update_fields)
        if not self.code:
            self.code = 'TD%05d' % self.id
            self.save()

    def node_dsc(self):
        if self.node:
            return u'%s'%self.node.name
        else:
            return u'启动'

    def code_link(self):
        return format_html("<a href='/admin/{}/{}/{}'>{}</a>",
                           self.app_name,self.model_name,self.inst.object_id,self.code)
    code_link.allow_tags = True
    code_link.short_description = _("code")

    def href(self):
        import sys
        reload(sys)
        sys.setdefaultencoding("utf-8")
        ct = ContentType.objects.get(app_label=self.app_name,model=self.model_name)
        obj = ct.get_object_for_this_type(id=self.inst.object_id)
        title = u"%s" % (obj)
        return format_html("<a href='/admin/{}/{}/{}'>{}</a>",
                           self.app_name,self.model_name,self.inst.object_id,title)
    def modal_dsc(self):
        return u'%s'%(self.inst.modal.name)
    modal_dsc.short_description = u'业务流程'

    def start_time(self):
        return self.inst.start_time.strftime('%Y-%m-%d %H:%M')

    href.allow_tags = True
    href.short_description = _("description")
    node_dsc.short_description = _('current node')

    def submitter(self):
        if self.inst.starter.last_name or self.inst.starter.first_name:
            return u"%s%s"%(self.inst.starter.last_name,self.inst.starter.first_name)
        return u"%s"%(self.inst.starter.username)
    submitter.short_description = _("submitter")

    class Meta:
        verbose_name = _("workflow todo")
        verbose_name_plural = _("workflow todo")
        ordering = ['user','-arrived_time']


def get_modal(app_label,model_name):
    """

    :param app_label:
    :param model_name:
    :return:
    """
    try:
        return Modal.objects.get(app_name=app_label,model_name=model_name)
    except Exception,e:
        return None


def get_instance(obj):
    """

    :param obj:
    :return:
    """
    if obj and obj._meta:
        modal = get_modal(obj._meta.app_label,obj._meta.model_name)
        if modal:
            try:
                return Instance.objects.get(modal=modal,object_id=obj.id)
            except Exception,e:
                return None
    else:
        return None
