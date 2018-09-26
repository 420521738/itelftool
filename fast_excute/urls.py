#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from fast_excute import views

urlpatterns = [
    # 项目上线 开始
    url(r'^coderelease/$', views.coderelease, name='coderelease'),
    url(r'^coderelease/add/$', views.coderelease_add, name='coderelease_add'),
    url(r'^coderelease/status/(?P<project_id>\d+)/$', views.coderelease_status, name='coderelease_status'),
    url(r'^coderelease/edit/(?P<project_id>\d+)/$', views.coderelease_edit, name='coderelease_edit'),
    url(r'^coderelease/del/$', views.coderelease_del, name='coderelease_del'),
    
    url(r'^coderelease/deploy/(?P<project_id>\d+)/$', views.coderelease_deploy, name='coderelease_deploy'),
    url(r'^coderelease/taskstop/(?P<project_id>\d+)/$', views.coderelease__stop, name='coderelease__stop'),
    url(r'^coderelease/log/(?P<project_id>\d+)/$', views.coderelease_log, name='coderelease_log'),
    url(r'^coderelease/log2/(?P<project_id>\d+)/$', views.coderelease_log2, name='coderelease_log2'),
    # 项目上线 结束
    
    # 执行记录 开始
    url(r'^coderelease/record/$', views.coderelease_record, name='coderelease_record'),
    url(r'^coderelease/record/export/$', views.coderelease_record_export, name='coderelease_record_export'),
    # 执行记录 结束
]