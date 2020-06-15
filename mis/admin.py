from django.contrib import admin


class AdminSite(admin.AdminSite):
    site_header = 'Django-ERP'
    site_title = 'ERP'
    index_title = 'ERP'
