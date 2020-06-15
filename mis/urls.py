from django.conf.urls import include, url, static
from django.contrib import admin
from mis import settings
import workflow.views
import invent.urls
import basedata.urls
import selfhelp.urls
import mis.views

urlpatterns = [
    url(r'^$', mis.views.home),
    url(r"^admin/(?P<app>\w+)/(?P<model>\w+)/(?P<object_id>\d+)/change/start", workflow.views.start),
    url(r"^admin/(?P<app>\w+)/(?P<model>\w+)/(?P<object_id>\d+)/change/approve/(?P<operation>\d+)", workflow.views.approve),
    url(r"^admin/(?P<app>\w+)/(?P<model>\w+)/(?P<object_id>\d+)/change/restart/(?P<instance>\d+)", workflow.views.restart),
    url(r'^admin/', admin.site.urls),
    url(r'^admin/invent/', include(invent.urls)),
    url(r'^admin/basedata/', include(basedata.urls)),
    url(r'^admin/selfhelp/', include(selfhelp.urls)),
]
urlpatterns += static.static(settings.STATIC_URL,document_root=settings.STATIC_ROOT)
urlpatterns += static.static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
