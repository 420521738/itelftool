#! /usr/bin/env python
# -*- coding: utf-8 -*-
from django.conf.urls import url, include
from navi import views

urlpatterns = [
    # 站点导航首页
    url(r'^$', views.index, name='navi'),
    # 站点编辑页的站点添加功能
    url(r'^add/', views.add, name='add'),
    # 站点编辑功能
    url(r'^manage/', views.manage, name='manage'),
    # 站点编辑页的站点添加功能
    url(r'^delete/', views.delete, name='delete'),
    # 站点编辑页的站点信息修改功能
    url(r'^edit/', views.edit, name='edit'),
    # 站点编辑页的站点信息修改保存功能
    url(r'^save/', views.save, name='save'),
]