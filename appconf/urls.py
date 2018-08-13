#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from appconf import views

urlpatterns = [
    # 产品线管理 开始
    url(r'^$', views.product_list, name='appconf'),
    url(r'^product/list/$', views.product_list, name='product_list'),
    url(r'^product/add/$', views.product_add, name='product_add'),
    url(r'^product/edit/(?P<product_id>\d+)/$', views.product_edit, name='product_edit'),
    url(r'^product/delete/$', views.product_del, name='product_del'),
    url(r'^product/project_list/(?P<product_id>\d+)/$', views.project_list, name='product_project_list'),
    # 产品线管理 结束
    
    # 项目管理 开始
    url(r'^project/list/$', views.project_projectlist, name='project_list'),
    url(r'^project/add/$', views.project_add, name='project_add'),
    url(r'^project/edit/(?P<project_id>\d+)/$', views.project_edit, name='project_edit'),
    url(r'^project/delete/$', views.project_del, name='project_del'),
    url(r'^project/export/$', views.project_export, name='project_export'),
    # 项目管理 结束
    
    
    url(r'^appowner/add/$', views.appowner_add, name='appowner_add'),
    url(r'^appowner/add/mini/$', views.appowner_add_mini, name='appowner_add_mini'),
    url(r'^appowner/list/$', views.appowner_list, name='appowner_list'),
    url(r'^appowner/edit/(?P<appowner_id>\d+)/$', views.appowner_edit, name='appowner_edit'),
    url(r'^appowner/delete/$', views.appowner_del, name='appowner_del'),
    
    
    

    
    

]