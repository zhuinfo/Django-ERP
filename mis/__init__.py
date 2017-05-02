#! /usr/bin/env python
# -*- coding: utf-8 -*-
import pymysql
pymysql.install_as_MySQLdb()
#解决mysql-python的历史遗留问题(Yuri_2017-04-29)
from django.contrib import admin

admin.site.site_header = 'Django-ERP'
admin.site.site_title = 'ERP'