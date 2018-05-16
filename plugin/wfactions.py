# created at 15-6-30 
# coding=utf-8
import logging
__author__ = 'zhugl'


class Operation(object):
    APPROVE = 1
    DENY = 3
    TERMINATE = 4


class WorkflowAction(object):

    name = ''
    description = ''

    def action(self,request,obj,node_config,operation=Operation.APPROVE):
        """

        :param request:
        :param obj:
        :param node_config:
        :return:
        """


class TestAction(WorkflowAction):
    name = 'action.test'

    def action(self,request,obj,node_config,operation=Operation.APPROVE):
        logging.info('this is a workflow test action')
        logging.info('request user is %s,current node is %s'%(request.user,node_config))


class WorkflowActionManager(object):
    """

    """
    actions = {}
    registed = False

    def __init__(self):
        if WorkflowActionManager.registed:
            pass
        else:
            WorkflowActionManager.register(TestAction)
            WorkflowActionManager.registed = True

    @classmethod
    def register(cls,action):
        if cls.actions.get(action.name):
            raise Exception('%s already exists,register failed'%action.name)
        if issubclass(action,WorkflowAction):
            WorkflowActionManager.actions[action.name] = action()