from django.contrib.admin.apps import AdminConfig


class MisAdminConfig(AdminConfig):
    default_site = 'mis.admin.AdminSite'
