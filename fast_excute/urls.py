#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from fast_excute import views

urlpatterns = [
    # 项目上线 开始
    # 项目上线列表
    url(r'^coderelease/$', views.coderelease, name='coderelease'),
    # 项目添加
    url(r'^coderelease/add/$', views.coderelease_add, name='coderelease_add'),
    # 项目执行状态查询
    url(r'^coderelease/status/(?P<project_id>\d+)/$', views.coderelease_status, name='coderelease_status'),
    # 项目编辑
    url(r'^coderelease/edit/(?P<project_id>\d+)/$', views.coderelease_edit, name='coderelease_edit'),
    # 项目删除
    url(r'^coderelease/del/$', views.coderelease_del, name='coderelease_del'),
    # 项目执行
    url(r'^coderelease/deploy/(?P<project_id>\d+)/$', views.coderelease_deploy, name='coderelease_deploy'),
    # 项目停止
    url(r'^coderelease/taskstop/(?P<project_id>\d+)/$', views.coderelease__stop, name='coderelease__stop'),
    # 项目查看日志中间人功能
    url(r'^coderelease/log/(?P<project_id>\d+)/$', views.coderelease_log, name='coderelease_log'),
    # 日志实时显示功能
    url(r'^coderelease/log2/(?P<project_id>\d+)/$', views.coderelease_log2, name='coderelease_log2'),
    # 项目上线 结束
    
    # 执行记录 开始
    # 执行记录展示
    url(r'^coderelease/record/$', views.coderelease_record, name='coderelease_record'),
    # 执行记录导出
    url(r'^coderelease/record/export/$', views.coderelease_record_export, name='coderelease_record_export'),
    # 每次更新的执行过程详情查看
    url(r'^coderelease/logdetail/(?P<codereleaserecord_id>\d+)/$', views.coderelease_logdetail, name='coderelease_logdetail'),
    # 执行记录 结束
]