#!/usr/bin/env python
#coding:utf-8

from django.conf.urls import url

from . import consumers

# 这个是从webshell.html页面进来的websocket请求，这样的ws请求并不是从url进来的，分清楚了
websocket_urlpatterns = [
    url(r'^ws/$', consumers.EchoConsumer),
]