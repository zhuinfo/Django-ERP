# coding=utf-8
import datetime
import os
import xlrd
import decimal
from django.db import transaction
from django.db import models
from django.contrib.auth.models import User
from django.utils.text import force_text
from django.utils.translation import ugettext_lazy as _
from common import generic
from common import const
from mis import settings
from basedata.models import Material,ExtraParam,Project,ExpenseAccount,Measure
from organ.models import OrgUnit


class WorkOrder(generic.BO):
    """

    """
    index_weight = 1
    code = models.CharField(_("workorder code"),blank=True,null=True,max_length=const.DB_CHAR_CODE_10)
    refer = models.ForeignKey("self",verbose_name=_("refer wo"),blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_120)
    description = models.TextField(_("description"),blank=True,null=True)
    business_domain = models.CharField(_("business domain"),max_length=const.DB_CHAR_CODE_4,choices=const.get_value_list('S045'),default='OT')
    classification = models.CharField(_("classification"),max_length=const.DB_CHAR_CODE_4,choices=const.get_value_list('S044'),default='D')
    service = models.ForeignKey(Material,verbose_name=_("service name"),null=True,blank=True,limit_choices_to={"is_virtual":"1"})
    project = models.ForeignKey(Project,verbose_name=_("project"),null=True,blank=True)
    status = models.CharField(_("status"),blank=True,null=True,default='NEW',max_length=const.DB_CHAR_CODE_6,choices=const.get_value_list('S046'))
    answer = models.TextField(_("answer"),blank=True,null=True)
    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)
    attach = models.FileField(_('attach'),blank=True,null=True,help_text=u'工单附件，不导入明细。')
    detail = models.FileField(_('to be imported detail'),blank=True,null=True,help_text=u'您可导入需求明细，模板请参考文档FD0007')

    def __unicode__(self):
        return u"%s-%s" % (self.code,self.title)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(WorkOrder,self).save(force_insert,force_update,using,update_fields)
        if self.service:
            material = self.service
            if self.woextravalue_set.count() < 1 and material.extraparam_set and material.extraparam_set.count() > 0:
                for param in material.extraparam_set.all():
                    extra_param = WOExtraValue.objects.create(workorder=self,param_name=param)
                    self.woextravalue_set.add(extra_param)
        item_count = WOItem.objects.filter(workorder=self).count()
        if self.detail and item_count == 0:
            path = os.path.join(settings.MEDIA_ROOT,self.detail.name)
            workbook = xlrd.open_workbook(path)
            sheet = workbook.sheet_by_index(0)
            row_count = sheet.nrows
            with transaction.atomic():
                for row_index in range(row_count):
                    row = sheet.row_values(row_index)
                    if row_index == 0:
                        doc_type = row[1]
                        if doc_type.startswith('0'):
                            break
                        else:
                            continue
                    elif row_index < 3:
                        continue
                    material = None
                    measure = None
                    try:
                        measure = Measure.objects.get(code=row[4])
                    except Exception,e:
                        measure = Measure.objects.create(code=row[4],name=force_text(row[5]))
                    try:
                        material = Material.objects.get(code=row[0])
                    except Exception,e:
                        material = Material(code=row[0],name=force_text(row[1]),spec=force_text(row[2]))
                        material.save()
                    WOItem.objects.create(workorder=self,material=material,measure=measure,amount=row[6])

    class Meta:
        verbose_name = _("workorder apply")
        verbose_name_plural = _("workorder apply")

    class Media:
        js = ('js/workorder.js',)


class WOExtraValue(models.Model):
    """

    """
    workorder = models.ForeignKey(WorkOrder,verbose_name=_("workorder"))
    param_name = models.ForeignKey(ExtraParam,verbose_name=_("extra param"))
    param_value = models.CharField(_("param value"),blank=True,null=True,max_length=const.DB_CHAR_NAME_40)

    class Meta:
        verbose_name = _("extra value")
        verbose_name_plural = _("extra values")


class WOItem(models.Model):
    """

    """
    workorder = models.ForeignKey(WorkOrder,verbose_name=_("workorder"))
    material = models.ForeignKey(Material,verbose_name=_("material"),null=True,blank=True,limit_choices_to={"is_virtual":"0"})
    amount = models.DecimalField(_("amount"),max_digits=10,decimal_places=4,blank=True,null=True)
    measure = models.ForeignKey(Measure,verbose_name=_('measure'),blank=True,null=True)
    price = models.DecimalField(_("price"),max_digits=10,decimal_places=4,blank=True,null=True)

    class Meta:
        verbose_name = _("workorder item")
        verbose_name_plural = _("workorder items")


class Loan(generic.BO):
    """

    """
    LOAD_STATUS = (
        ('N',_("NEW")),
        ('I',_("IN PROGRESS")),
        ('A',_("APPROVED")),
        ('P',_("PAYED"))
    )
    index_weight = 3
    code = models.CharField(_("loan code"),max_length=const.DB_CHAR_CODE_10,blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_120)
    description = models.TextField(_("description"),blank=True,null=True)
    project = models.ForeignKey(Project,verbose_name=_("project"))
    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)
    status = models.CharField(_("status"),blank=True,null=True,default='N',max_length=const.DB_CHAR_CODE_2,choices=LOAD_STATUS)
    logout_time = models.DateTimeField(_("logout time"),blank=True,null=True)
    loan_amount = models.DecimalField(_("loan amount"),max_digits=10,decimal_places=2,blank=True,null=True)
    logout_amount = models.DecimalField(_("logout amount"),max_digits=10,decimal_places=2,blank=True,null=True)
    pay_user = models.CharField(_('pay user'),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)
    pay_time = models.DateTimeField(_('pay time'),blank=True,null=True)
    is_clear = models.BooleanField(_('is clear'),default=False)

    def __unicode__(self):
        import decimal
        left = self.loan_amount
        left -= self.logout_amount or decimal.Decimal(0.00)
        name = '%s%s'%(self.user.last_name,self.user.first_name)
        return '%s %s %s J:%.2f Y:%.2f' % (self.code,name,self.title,self.loan_amount,left)

    def applier(self):
        return u'%s%s'%(self.user.last_name,self.user.first_name)

    applier.short_description = _('applier')

    def action_pay(self,request):
        self.pay_time = datetime.datetime.now()
        self.pay_user = request.user.username
        self.status = 'P'
        self.save()

    class Meta:
        verbose_name = _("loan")
        verbose_name_plural = _("loans")
        permissions = (
            ('financial_pay',_("financial pay")),
        )


class Reimbursement(generic.BO):
    """

    """
    REIM_STATUS = (
        ('N',_("NEW")),
        ('I',_("IN PROGRESS")),
        ('A',_("APPROVED")),
        ('P',_("PAYED"))
    )
    index_weight = 2
    code = models.CharField(_("fee code"),max_length=const.DB_CHAR_CODE_10,blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_120)
    description = models.TextField(_("description"),blank=True,null=True)
    project = models.ForeignKey(Project,verbose_name=_("project"))
    wo = models.ForeignKey(WorkOrder,verbose_name=_("work order"),null=True,blank=True)
    user = models.ForeignKey(User,verbose_name=_("user"),blank=True,null=True)
    org = models.ForeignKey(OrgUnit,verbose_name=_("cost center"),blank=True,null=True)
    bank_account = models.CharField(_("bank account"),max_length=const.DB_CHAR_NAME_120,blank=True,null=True)
    status = models.CharField(_("status"),blank=True,null=True,default='N',max_length=const.DB_CHAR_CODE_2,choices=REIM_STATUS)
    amount = models.DecimalField(_("amount of money"),max_digits=10,decimal_places=2,blank=True,null=True)
    loan = models.ForeignKey(Loan,verbose_name=_("loan record"),blank=True,null=True)
    loan_amount = models.DecimalField(_("loan amount"),max_digits=10,decimal_places=2,blank=True,null=True)
    logout_amount = models.DecimalField(_("logout amount"),max_digits=10,decimal_places=2,blank=True,null=True)
    pay_amount = models.DecimalField(_("pay amount"),max_digits=10,decimal_places=2,blank=True,null=True)
    pay_time = models.DateTimeField(_("pay time"),blank=True,null=True)
    pay_user = models.CharField(_('pay user'),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)

    def applier(self):
        return u'%s%s'%(self.user.last_name,self.user.first_name)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        import decimal
        if self.loan:
            left = self.loan.loan_amount
            left -= self.loan.logout_amount or decimal.Decimal(0.00)
            if self.logout_amount is None or self.logout_amount == '':
                if self.amount < left:
                    self.logout_amount = self.amount
                else:
                    self.logout_amount = left
        self.pay_amount = self.amount
        if self.logout_amount:
            self.pay_amount -= self.logout_amount
        super(Reimbursement,self).save(force_insert,force_update,using,update_fields)

    def action_pay(self,request):
        if self.loan:
            if self.logout_amount is None or self.logout_amount == '':
                self.logout_amount = self.amount
            if self.logout_amount < 0:
                raise Exception(u'核销金额小于0')

            if self.loan.logout_amount is None:
                self.loan.logout_amount = self.logout_amount
            else:
                self.loan.logout_amount += self.logout_amount

            if self.loan.loan_amount == self.loan.logout_amount:
                self.loan.is_clear=True

            self.loan.logout_time = datetime.datetime.now()
            self.loan.save()

        if self.amount > self.logout_amount:
            self.pay_amount = self.amount - self.logout_amount

        self.pay_time = datetime.datetime.now()
        self.pay_user = request.user.username
        self.status = 'P'
        self.save()

    applier.short_description = _('applier')

    class Meta:
        verbose_name = _("reimbursement")
        verbose_name_plural = _("reimbursements")
        permissions = (
            ('financial_pay',_("financial pay")),
        )


class ReimbursementItem(models.Model):
    """

    """
    import datetime
    reimbursement = models.ForeignKey(Reimbursement,verbose_name=_("reimbursement"))
    expense_account = models.ForeignKey(ExpenseAccount,verbose_name=_("expenses account"))
    begin = models.DateField(_("occur date"),default=datetime.date.today)
    amount = models.DecimalField(_("amount of money"),max_digits=10,decimal_places=2)
    memo = models.CharField(_("memo"),max_length=const.DB_CHAR_NAME_40,blank=True,null=True)

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        super(ReimbursementItem,self).save(force_insert,force_update,using,update_fields)
        sql = 'UPDATE selfhelp_reimbursement SET amount = (SELECT SUM(amount) FROM selfhelp_reimbursementitem WHERE reimbursement_id = %s) WHERE id = %s'
        params = [self.reimbursement.id,self.reimbursement.id]
        generic.update(sql,params)

    class Meta:
        verbose_name = _("fee item")
        verbose_name_plural = _("fee items")


class Activity(generic.BO):
    """

    """
    CLASSIFICATION = (
        ('T',_("Train")),
        ('M',_("Meeting")),
        ('G',_("Community")),
    )
    index_index_weight = 4
    begin_time = models.DateTimeField(_('begin time'))
    end_time = models.DateTimeField(_('end time'))
    enroll_deadline = models.DateTimeField(_('enroll deadline'),blank=True,null=True)
    code = models.CharField(_("code"),max_length=const.DB_CHAR_NAME_20,blank=True,null=True)
    title = models.CharField(_("title"),max_length=const.DB_CHAR_NAME_120)
    parent = models.ForeignKey('self',verbose_name=_("parent"),blank=True,null=True)
    description = models.TextField(_("description"),blank=True,null=True)
    host = models.CharField(_("host"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    speaker = models.CharField(_("speaker"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    accept_enroll = models.BooleanField(_("accept enroll"),default=1)
    room = models.ForeignKey(Material,verbose_name=_("room"),blank=True,null=True,limit_choices_to={'tp':20})
    location = models.CharField(_("location"),max_length=const.DB_CHAR_NAME_80,blank=True,null=True)
    classification = models.CharField(_("classification"),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=CLASSIFICATION,default='M')
    mail_list = models.TextField(_("mail list"),blank=True,null=True)
    mail_notice = models.BooleanField(_("mail notice"),default=1)
    short_message_notice = models.BooleanField(_("short message notice"),default=1)
    weixin_notice = models.BooleanField(_("weixin notice"),default=1)
    status = models.BooleanField(_("published"),default=0)
    publish_time = models.DateTimeField(_("publish time"),blank=True,null=True)
    attach = models.FileField(_("attach"),blank=True,null=True,upload_to='activity')

    class Meta:
        verbose_name = _("activity")
        verbose_name_plural = _("activities")


class Feedback(models.Model):
    """

    """
    RANK = (
        ('A','A'),
        ('B','B'),
        ('C','C'),
        ('D','D'),
    )
    activity = models.ForeignKey(Activity)
    user = models.ForeignKey(User)
    feed_time = models.DateTimeField(_("feedback time"),auto_now_add=True)
    rank = models.CharField(_('rank'),max_length=const.DB_CHAR_CODE_2,blank=True,null=True,choices=RANK,default='B')
    comment = models.CharField(_("suggest"),blank=True,null=True,max_length=const.DB_CHAR_NAME_80)


class Enroll(models.Model):
    """

    """
    activity = models.ForeignKey(Activity)
    user = models.ForeignKey(User)
    enroll_time = models.DateTimeField(_("enroll time"),auto_now_add=True)
