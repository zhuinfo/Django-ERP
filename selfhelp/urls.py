from django.conf.urls import include, url,static
import selfhelp.views

urlpatterns = [
    url(r"(?P<model>\w+)/(?P<object_id>\d+)/pay", selfhelp.views.pay_action),
]
