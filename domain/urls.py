#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from domain import views

urlpatterns = [
    # 产品线管理 开始
    url(r'^$', views.domain_list, name='domain_list'),
    url(r'^add/$', views.domain_add, name='domain_add'),
]