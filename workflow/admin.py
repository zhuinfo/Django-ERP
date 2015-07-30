from django.contrib import admin
from django.contrib.contenttypes.models import ContentType
from common import generic
from workflow.models import Modal,Node,TodoList,Instance,History


class NodeInline(admin.TabularInline):
    model = Node
    fields = ['code','name','next_user_handler','can_deny','can_terminate']

    def get_extra(self, request, obj=None, **kwargs):
        if obj:
            return 0
        else:
            return 1


class WorkflowModelAdmin(admin.ModelAdmin):
    list_display = ['code','name','begin','end']
    inlines = [NodeInline]
    readonly_fields = ['app_name','model_name']
    raw_id_fields = ['content_type']
    fields = (
        ('begin','end',),('code','name',),('description',),('content_type',),('app_name','model_name',),
    )

    def get_form(self, request, obj=None, **kwargs):
        print kwargs
        return super(WorkflowModelAdmin,self).get_form(request,obj,**kwargs)

    def save_model(self, request, obj, form, change):
        import datetime
        super(WorkflowModelAdmin,self).save_model(request,obj,form,change)

        if not obj.code:
            code = 'WF%03d' % obj.id
            obj.code = code
            obj.save()
        if not obj.begin:
            obj.begin = datetime.date.today()
            obj.end = datetime.date(9999,12,31)
        app_name = obj.content_type.app_label
        model_name = obj.content_type.model
        obj.app_name = app_name
        obj.model_name = model_name
        obj.save()


class WorkflowNodeAdmin(admin.ModelAdmin):
    fields = (
        ('modal',),
        ('name','code',),
        ('start','stop','can_terminate','can_deny','can_edit',),
        ('email_notice','short_message_notice','approve_node',),('next',),
        ('handler_type',),
        ('handler',),
        ('next_user_handler','next_node_handler',),
        ('status_field','status_value',),('action',),
        ('users',),('positions',),('roles',),
    )
    list_display = ['code','name','modal','can_deny','can_terminate']
    list_display_links = ['code','name']
    list_filter = ['modal']
    readonly_fields = ['modal','code']
    filter_horizontal = ['next','users','positions','roles','departments',]
    radio_fields = {'handler_type':admin.HORIZONTAL}
    search_fields = ['modal__code','modal__name','code','name']

    def get_readonly_fields(self, request, obj=None):
        if obj and obj.stop:
            return ['modal','code','next']
        return super(WorkflowNodeAdmin,self).get_readonly_fields(request,obj)

    def formfield_for_manytomany(self, db_field, request=None, **kwargs):
        if db_field.name == 'next':
            apps = generic.get_app_model_info_from_request(request)
            # print apps
            if apps and apps.get('obj'):
                # print 'it is here'
                obj = apps.get('obj')
                # print obj.modal
                kwargs['queryset'] = Node.objects.filter(modal=obj.modal).exclude(id=obj.id)
            else:
                kwargs['queryset'] = Node.objects.filter(id=-1)

        return super(WorkflowNodeAdmin,self).formfield_for_manytomany(db_field,request,**kwargs)


class InstanceAdmin(admin.ModelAdmin):
    list_display = ['code','modal','starter','start_time','status']
    readonly_fields = ['code','modal','starter','start_time','status','object_id','approved_time','current_nodes']


class TodoAdmin(admin.ModelAdmin):
    list_display = ['code_link','modal_dsc','href','node_dsc','is_read','status','submitter','arrived_time']
    list_filter = ['status']

    def get_queryset(self, request):
        return super(TodoAdmin,self).get_queryset(request).filter(user=request.user)


class HistoryAdmin(admin.ModelAdmin):
    list_display = ['inst','node','user','pro_time','memo']


class ContentTypeAdmin(admin.ModelAdmin):
    list_display = ['app_label','model']
    search_fields = ['app_label','model']
    list_per_page = 20
    list_filter = ['app_label']


admin.site.register(Modal, WorkflowModelAdmin)
admin.site.register(Node, WorkflowNodeAdmin)
admin.site.register(Instance, InstanceAdmin)
admin.site.register(TodoList, TodoAdmin)
admin.site.register(History, HistoryAdmin)
admin.site.register(ContentType,ContentTypeAdmin)
