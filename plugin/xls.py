# created at 15-6-27 
# coding=utf-8
__author__ = 'zhugl'
import xlrd
import os
import datetime
from mis import settings


class Handler(object):
    name = ''

    def handle(self,obj,f):
        pass


class OPSHandler(Handler):
    """
    导入基础信息：部门，岗位，职员
    """
    name = 'OPS'

    def handle(self,obj,f):
        if f and f.name.endswith('.xls'):
            path = os.path.join(settings.MEDIA_ROOT,f.name)
            workbook = xlrd.open_workbook(path)
            for sheet in workbook.sheets():
                if sheet.name == u'部门' or sheet.name == 'department':
                    self.department(obj,sheet)
                elif sheet.name == u'岗位' or sheet.name == 'position':
                    self.position(obj,sheet)
                elif sheet.name == u'职员' or sheet.name == 'employee':
                    self.stuff(obj,sheet)

    def department(self,obj,sheet):
        from organ.models import OrgUnit
        row_count = sheet.nrows
        if obj.is_clear:
            OrgUnit.objects.update(end=datetime.date.today())
        for row_index in range(1,row_count):
            row = sheet.row_values(row_index)
            weight = 99
            if row[6]:
                weight = row[6]
            OrgUnit.objects.create(code=row[0],name=row[1],short=row[2],pinyin=row[3],begin=datetime.date.today(),
                                   end=datetime.date(9999,12,31),weight=weight)
        for row_index in range(1,row_count):
            row = sheet.row_values(row_index)
            if len(row[4]) > 0:
                try:
                    parent = OrgUnit.objects.get(code=row[4])
                    OrgUnit.objects.filter(code=row[0]).update(parent=parent)
                except Exception,e:
                    pass

    def position(self,obj,sheet):
        from organ.models import Position,OrgUnit
        row_count = sheet.nrows
        if obj.is_clear:
            Position.objects.update(end=datetime.date.today())
        for row_index in range(1,row_count):
            row = sheet.row_values(row_index)
            depart = None
            if len(row[4]) > 0:
                try:
                    depart = OrgUnit.objects.filter(code=row[4],end__gt=datetime.date.today()).all()[0]
                except Exception,e:
                    pass
            weight = 99
            if row[6]:
                weight = row[6]
            Position.objects.create(code=row[0],name=row[1],unit=depart,begin=datetime.date.today(),
                                    end=datetime.date(9999,12,31),weight=weight)
        for row_index in range(1,row_count):
            row = sheet.row_values(row_index)
            if len(row[2]) > 0:
                try:
                    parent = Position.objects.filter(code=row[2],end__gt=datetime.date.today()).all()[0]
                    Position.objects.filter(code=row[0]).update(parent=parent)
                except Exception,e:
                    pass

    def stuff(self,obj,sheet):
        from organ.models import Position
        from basedata.models import Employee
        from django.contrib.auth.models import User,Group
        row_count = sheet.nrows
        try:
            group = Group.objects.get_by_natural_key(u'职员')
        except Exception,e:
            pass
        for row_index in range(1,row_count):
            row = sheet.row_values(row_index)
            position = Position.objects.filter(code=row[8],end__gt=datetime.date.today()).all()[0]
            username = row[10]
            email = row[11]
            password = row[4][-6:]
            if position is None:
                raise Exception(u'职员%s-%s未分配岗位，或者您选择的岗位已失效，不可被引用'%(row[0],row[1]))
            try:
                employee = Employee.objects.get(code=row[0])
                if employee.position.code == row[8]:
                    continue
                else:
                    employee.position = position
                    employee.save()
            except Exception,e:
                employee = Employee.objects.create(code=row[0],name=row[1],pinyin=row[2],gender=row[3],idcard=row[4],
                                    birthday=row[5],workday=row[6],startday=row[7],position=position)
            if username:
                try:
                    user = User.objects.get_by_natural_key(username)
                except Exception,e:
                    user = User.objects.create_user(username=username,password=password)
                    user.is_staff = True
                    user.is_active = True
                    user.first_name = row[1]
                    if email:
                        user.email = email
                    if group:
                        user.groups.add(group)
                    user.save()
                employee.user = user
                employee.save()


class UserHandler(Handler):
    """
    基础数据导入：用户
    """
    name = 'admin.user'

    def handle(self,obj,f):
        from django.contrib.auth.models import User,Group
        if f and f.name.endswith('.xls'):
            path = os.path.join(settings.MEDIA_ROOT,f.name)
            workbook = xlrd.open_workbook(path)
            sheet = workbook.sheet_by_index(0)
            row_count = sheet.nrows
            try:
                group = Group.objects.get_by_natural_key(u'职员')
            except Exception,e:
                pass

            for row_index in range(2,row_count):
                row = sheet.row_values(row_index)
                username = row[0]
                password = row[1]
                last_name = row[2]
                first_name = row[3]
                email = row[4]
                if username == '':
                    continue
                try:
                    user = User.objects.get_by_natural_key(username)
                except Exception,e:
                    user = User.objects.create_user(username=username,password=password,email=email)
                    user.is_staff = True
                    user.is_active = True
                    user.last_name = last_name
                    user.first_name = first_name
                    if group:
                        user.groups.add(group)
                    user.save()


class ExcelManager(object):
    """

    """
    handlers = {}

    def __init__(self):
        ExcelManager.register(OPSHandler)
        ExcelManager.register(UserHandler)

    @classmethod
    def register(cls,handler):
        if cls.handlers.get(handler.name):
            raise Exception('%s already exists,register failed'%handler.name)
        if issubclass(handler,Handler):
            ExcelManager.handlers[handler.name] = handler()

