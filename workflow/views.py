# coding=utf-8
from django.contrib.admin import site
from django.contrib.contenttypes.models import ContentType
from django.db import connection
from django.http.response import HttpResponseRedirect
from django.utils.encoding import force_text
from django.template.response import TemplateResponse
from django.contrib import messages
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from workflow.models import Modal,Instance,TodoList,History,Node
from plugin.wfnodes import NextNodeManager,NextNodeHandler
from plugin.wfusers import NextUserManager,NextUserHandler
from plugin.wfactions import WorkflowActionManager,WorkflowAction


SELECTED_CHECKBOX_NAME = 'NEXT_NODE_USER'


def compile_node_handler(request,obj,next_node):
    """
    :param request:
    :param obj:
    :param handler:
    :return:
    """

    handler = next_node.handler
    next_user_handler = next_node.next_user_handler
    # next_user_handler 具有最高优先级
    if next_user_handler:
        # print 'it is here'
        klass = NextUserManager().handlers.get(next_user_handler)
        if klass and isinstance(klass,NextUserHandler):
            return klass.handle(request,obj,next_node)

    if handler and handler != '':
        handler = handler.replace("submitter()", request.user.username)
        handler = handler.replace("suber()", request.user.username)
        fields = obj._meta.fields
        for field in fields:
            name = field.name
            temp = "{{%s}}" % name
            val = getattr(obj,name,None)
            if val:
                if type(val)!=str:
                    val = str(val)
                handler = handler.replace(temp,val)
        cursor = connection.cursor()
        cursor.execute(handler)
        rows = [row for row in cursor.fetchall()]
        return rows
    else:
        tp = next_node.handler_type
        if tp == 1 and next_node.users:
            # user
            users = [user for user in next_node.users.all()]
            return users
        elif tp == 2 and next_node.positions:
            # position
            users = []
            for position in next_node.positions.all():
                for employee in position.employee_set.all():
                    users.append(employee.user)
            return users
        elif tp == 3 and next_node.roles:
            # role
            users = []
            for role in next_node.roles.all():
                for user in role.users.all():
                    users.append(user)
            return users
        elif tp == 4:
            # submitter
            return request.user
        else:
            return None


def start(request,app,model,object_id):
    """

    :param request:
    :return:
    """
    import datetime
    content_type = ContentType.objects.get(app_label=app,model=model)
    obj = content_type.get_object_for_this_type(id=int(object_id))
    title = _("Are you sure?")
    opts = obj._meta
    objects_name = force_text(opts.verbose_name)
    has_workflow = False
    queryset = Modal.objects.filter(content_type=content_type,end__gt=datetime.date.today()).order_by('-end')
    cnt = queryset.count()
    workflow_modal = None
    next_node = None
    next_users = []
    has_next_user = False
    if cnt > 0:
        has_workflow = True
        workflow_modal = queryset[0]
        query_start_node = workflow_modal.node_set.filter(start=1)
        query_first_node = workflow_modal.node_set.order_by('id')
        if query_start_node.count() > 0:
            next_node = query_start_node[0]
        elif query_first_node.count()>0:
            next_node = query_first_node[0]
        if next_node:
            next_users = compile_node_handler(request,obj,next_node)
            if len(next_users) > 0:
                has_next_user = True
    else:
        title = _("No workflow model was found")

    try:
        tmp = Instance.objects.get(modal = workflow_modal,object_id=object_id)
        messages.warning(request,_("the object is already in workflow"))
        return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))
    except Exception:
        pass

    if request.POST.get("post"):
        val = request.POST.getlist(SELECTED_CHECKBOX_NAME)
        workflow_inst = Instance.objects.create(modal=workflow_modal,object_id=object_id,starter=request.user)
        workflow_inst.current_nodes.add(next_node)
        workflow_inst.save()
        workflow_history = History.objects.create(inst=workflow_inst,user=request.user)
        for user in User.objects.filter(id__in=val):
            todo = TodoList.objects.create(inst=workflow_inst,node=next_node,user=user,app_name=app,model_name=model)
        TodoList.objects.create(inst=workflow_inst,user=request.user,app_name=app,model_name=model,is_read=True,
                                read_time=datetime.datetime.now(),status=True)
        if next_node.status_field and next_node.status_value:
            try:
                setattr(obj,next_node.status_field,next_node.status_value)
                obj.save()
            except Exception,e:
                pass
        messages.success(request,_('workflow started successfully'))
        return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))

    context = dict(
        site.each_context(request),
        title=title,
        opts=opts,
        objects_name=objects_name,
        object=obj,
        has_workflow = has_workflow,
        workflow_modal = workflow_modal,
        next_node = next_node,
        has_next_user = has_next_user,
        next_users = next_users,
        checkbox_name = SELECTED_CHECKBOX_NAME,
    )
    request.current_app = site.name

    return TemplateResponse(request,'default/workflow/workflow_start_confirmation.html', context)


def approve(request,app,model,object_id,operation):
    """

    :param request:
    :param operation:
    :return:
    """
    if operation not in ('1','3','4'):
        messages.warning(request,_("unkown workflow operation"))
        return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))

    import datetime
    import copy
    content_type = ContentType.objects.get(app_label=app,model=model)
    obj = content_type.get_object_for_this_type(id=int(object_id))
    title = _("Are you sure?")
    opts = obj._meta
    objects_name = force_text(opts.verbose_name)

    has_workflow = False
    queryset = Modal.objects.filter(content_type=content_type,end__gt=datetime.date.today()).order_by('-end')
    cnt = queryset.count()
    workflow_modal = None
    if cnt > 0:
        workflow_modal = queryset[0]
    else:
        messages.warning(request,_("No workflow model was found"))
        return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))
    workflow_instance = None
    try:
        workflow_instance = Instance.objects.get(modal = workflow_modal,object_id=object_id)
    except Exception:
        messages.warning(request,_("please start the workflow first"))
        return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))

    next_nodes = []
    node_users = []
    is_stop_node = False
    node_has_users = False
    delete_instance = False
    deny_to_first = False
    next_node_description = None
    all_nodes =[x for x in Node.objects.filter(modal=workflow_modal).order_by('-id')]
    current = workflow_instance.current_nodes.all()
    current_tmp = copy.deepcopy(current[0])
    if operation == '4' or operation == '3':
        next_nodes = ['stop']
        is_stop_node = True
    else:
        if current.count() > 1:
            pass
        else:
            tmp_node = current[0]
            if tmp_node.stop or tmp_node == all_nodes[0]:
                next_nodes = ['stop']
                is_stop_node = True
            else:
                if tmp_node.next_node_handler and len(tmp_node.next_node_handler) > 0:
                    hd = tmp_node.next_node_handler
                    klass = NextNodeManager().handlers.get(hd)
                    if klass and isinstance(klass,NextNodeHandler):
                        next_nodes = klass.handle(request,obj,tmp_node)
                        next_node_description = klass.description
                if next_nodes and len(next_nodes) > 0:
                    pass
                elif tmp_node.next and tmp_node.next.count()>0:
                    next_nodes = [nd for nd in tmp_node.next.all()]
                else:
                    position = all_nodes.index(tmp_node)
                    next_nodes = [all_nodes[position-1]]

    if request.POST.get("post"):
        from django.db import transaction
        val = request.POST.getlist(SELECTED_CHECKBOX_NAME)
        memo = request.POST['memo']
        with transaction.atomic():
            try:
                if delete_instance:
                    workflow_instance.delete()
                else:
                    if is_stop_node:
                        workflow_instance.status = 99
                        if operation in ('3', '4'):
                            workflow_instance.status = int(operation)
                        if not workflow_instance.approved_time and operation == '1':
                            workflow_instance.approved_time = datetime.datetime.now()
                        workflow_instance.current_nodes.clear()
                        workflow_instance.save()
                    else:
                        workflow_instance.current_nodes.clear()
                        workflow_instance.current_nodes.add(next_nodes[0])
                        for user in User.objects.filter(id__in=val):
                            todo = TodoList.objects.create(inst=workflow_instance,node=next_nodes[0],user=user,app_name=app,model_name=model)
                        if current_tmp.status_field and current_tmp.status_value:
                            try:
                                setattr(obj,current_tmp.status_field,current_tmp.status_value)
                                obj.save()
                            except Exception,e:
                                pass
                    History.objects.create(inst=workflow_instance,user=request.user,pro_type=int(operation),memo=memo,node=current_tmp)
                    TodoList.objects.filter(inst=workflow_instance,node=current_tmp,status=0).update(status=1)
                messages.success(request,_('workflow approved successfully'))
            except Exception,e:
                messages.error(request,e)
                pass
            if current_tmp.action and len(current_tmp.action) > 0:
                action = WorkflowActionManager().actions.get(current_tmp.action)
                if action and isinstance(action,WorkflowAction):
                    action.action(request,obj,current_tmp,operation)

        return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))

    if len(next_nodes) > 0 and not is_stop_node and operation == '1':
        for node in next_nodes:
            users = compile_node_handler(request,obj,node)
            if len(users) > 0:
                node_has_users = True
            node_users.append({'node':node,'users':users})

    context = dict(
        site.each_context(request),
        title=title,
        opts=opts,
        objects_name=objects_name,
        object=obj,
        operation = operation,
        is_stop_node = is_stop_node,
        delete_instance = delete_instance,
        node_users = node_users,
        node_has_users = node_has_users,
        checkbox_name = SELECTED_CHECKBOX_NAME,
    )
    if next_node_description:
        context.update(dict(next_node_description=next_node_description))
    return TemplateResponse(request,"default/workflow/workflow_approve_confirmation.html",context)


def restart(request,app,model,object_id,instance):
    """

    :param request:
    :param app:
    :param model:
    :param object_id:
    :return:
    """
    try:
        inst = Instance.objects.get(id=int(instance))
        if request.user == inst.starter:
            inst.delete()
            messages.success(request,_("workflow restarted success"))
        else:
            messages.warning(request,_("you do not have the permission to restart,only the starter can restart"))
    except Exception,e:
        messages.error(request,e)
    return HttpResponseRedirect("/admin/%s/%s/%s"%(app,model,object_id))