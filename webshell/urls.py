#!/usr/bin/env python
#coding:utf-8

from django.conf.urls import url

from . import views

urlpatterns = [
    # This webshell中的帐号密码登录接口 开始
    url(r'^shell_terminal/$', views.shell_terminal_server_login, name='shell_terminal_server_login'),
    # This webshell中的帐号密码登录接口 结束
    
    # This webshell中的登录管理功能 开始
    url(r'^shell_terminal/(?P<ids>\d+)/$', views.shell_terminal, name='shell_terminal'),
    url(r'^ssh/$', views.ssh_list, name='ssh_list'),
    url(r'^ssh/add/$', views.ssh_add, name='ssh_add'),
    url(r'^ssh/edit/(?P<ids>\d+)/$', views.ssh_edit, name='ssh_edit'),
    url(r'^ssh/delete/(?P<ids>\d+)/$', views.ssh_del, name='ssh_del'),
    url(r'^ssh/serverlogin$', views.server_login, name='server_login'),
    # This webshell中的登录管理功能 结束
]
