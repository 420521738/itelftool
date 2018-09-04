#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from broken_record import views

urlpatterns = [
    # 故障管理 开始
    url(r'^list/$', views.brokenrecord_list, name='brokenrecord'),
    url(r'^list/(\d+)/$', views.brokenrecord_detail, name="brokenrecord_detail"),
    url(r'^add/$', views.brokenrecord_add, name='brokenrecord_add'),
    url(r'^edit/(?P<brokenrecord_id>\d+)/$', views.brokenrecord_edit, name='brokenrecord_edit'),
    url(r'^delete/$', views.brokenrecord_del, name='brokenrecord_del'),
    url(r'^export/$', views.brokenrecord_export, name='brokenrecord_export'),
]