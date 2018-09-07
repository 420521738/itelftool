#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from accounts import user

urlpatterns = [
    # 用户管理 开始
    url(r'^user/list/$', user.user_online_list, name='user_online_list'),
    # 用户管理 结束

]