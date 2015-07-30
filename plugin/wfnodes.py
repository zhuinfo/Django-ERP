# created at 15-6-30 
# coding=utf-8
__author__ = 'zhugl'
from workflow.models import Node


class NextNodeHandler(object):
    """

    """
    name = ''
    description = ''

    def handle(self,request,obj,node_config):
        """

        :param request:
        :param obj:
        :param node_config:
        :return:workflow.models.Node
        """
        return None


class TestHandler(NextNodeHandler):
    name = 'project.budge.gt.10000'
    description = '预算金额大于10000，由总经理审批'

    def handle(self,request,obj,node_config):
        budget = getattr(obj,'budget',None)
        if budget and budget > 10000:
            return Node.objects.filter(id=7).all()


class NextNodeManager(object):
    """

    """
    handlers = {}
    registed = False

    def __init__(self):
        if NextNodeManager.registed:
            pass
        else:
            NextNodeManager.register(TestHandler)
            NextNodeManager.registed = True

    @classmethod
    def register(cls,handler):
        if cls.handlers.get(handler.name):
            raise Exception('%s already exists,register failed'%handler.name)
        if issubclass(handler,NextNodeHandler):
            NextNodeManager.handlers[handler.name] = handler()
