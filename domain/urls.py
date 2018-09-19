#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from domain import views

urlpatterns = [
    # 域名管理中的域名信息管理 开始
    url(r'^$', views.domain_list, name='domain_list'),
    url(r'^add/$', views.domain_add, name='domain_add'),
    url(r'^delete/(?P<id>\d+)/$', views.domain_del, name='domain_del'),
    url(r'^update/(?P<id>\d+)/$', views.domain_update, name='domain_update'),
    # 域名管理中的域名信息管理 开始
    
    # 实时查询域名信息 开始
    url(r'^search/$', views.domain_search_input, name='domain_search_input'),
    url(r'^search/result/$', views.domain_search_result, name='domain_search_result'),
    # 实时查询域名信息 结束
]