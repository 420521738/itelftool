#!/usr/bin/env python
#coding:utf-8

from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
import webshell.routing

# 从django总入口进来的websocket请求来到这里，是从（settings）进来的
application = ProtocolTypeRouter({
    # (http->django views is added by default)
    # This websocket请求处理的url让webshell.routing.websocket_urlpatterns来处理，也就是让url(r'^ws/$', consumers.EchoConsumer)来处理
    'websocket': AuthMiddlewareStack(
        URLRouter(
            webshell.routing.websocket_urlpatterns
        )
    ),
})