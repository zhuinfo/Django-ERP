# coding=utf-8
from django.db import connection
from django.utils.translation import ugettext_lazy as _
__author__ = 'zhugl'

DB_CHAR_CODE_2 = 2
DB_CHAR_CODE_4 = 4
DB_CHAR_CODE_6 = 6
DB_CHAR_CODE_8 = 8
DB_CHAR_CODE_10 = 10

DB_CHAR_NAME_20 = 20
DB_CHAR_NAME_40 = 40
DB_CHAR_NAME_60 = 60
DB_CHAR_NAME_80 = 80
DB_CHAR_NAME_120 = 120
DB_CHAR_NAME_200 = 200


STATUS_ON_OFF = (
    (0,_('OFF')),
    (0,_('ON')),
)


def get_value_list(group):
    """
    获取值列表信息
    """
    if group:
        try:
            cursor = connection.cursor()
            cursor.execute('SELECT code,name FROM basedata_valuelistitem WHERE group_code=%s AND status=1',[group])
            rows = cursor.fetchall()
            return tuple([(code,name) for code,name in rows])
        except Exception as e:
            return None
    else:
        return None
