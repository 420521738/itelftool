#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.contrib.sessions.models import Session
from assets.myauth import UserProfile
import datetime

@login_required()
def user_online_list(request):
    # This 在线用户统计相关 开始
    # This获取没有过期的session
    sessions =Session.objects.filter(expire_date__gte=datetime.datetime.now())
    uid_list = []
    # This 获取session中的userid
    for session in sessions:
        data = session.get_decoded()
        uid_list.append(data.get('_auth_user_id', None))
    # Thist 根据userid查询user
    online_user = UserProfile.objects.filter(id__in=uid_list)
    # This 在线用户统计相关 结束
    kwargs = {
        'online_user':  online_user,
    }
    return render(request, 'accounts/user_online_list.html', kwargs)