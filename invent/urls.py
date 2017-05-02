from django.conf.urls import include, url,static
import invent.views

urlpatterns = [
    url(r"stockin/(?P<object_id>\d+)/cin", invent.views.action_in),
    url(r"initialinventory/(?P<object_id>\d+)/cin", invent.views.action_init),
    url(r"stockout/(?P<object_id>\d+)/out", invent.views.action_out),
    url(r"warereturn/(?P<object_id>\d+)/cin", invent.views.action_return),
    url(r"wareadjust/(?P<object_id>\d+)/adjust", invent.views.action_adjust),
]
