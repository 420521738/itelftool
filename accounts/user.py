#! /usr/bin/env python
# -*- coding: utf-8 -*-


from django.shortcuts import render, HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.contrib.sessions.models import Session
from assets.myauth import UserProfile
import datetime
from django.contrib.auth import get_user_model
from django.core.urlresolvers import reverse
from accounts.forms import AddUserForm, EditUserForm, ChangePasswordForm



# 前端个人中心功能
@login_required
def userinfo(request):
    username = request.user
    userInfo = UserProfile.objects.get(email=username)
    #print(userInfo.last_login)
    return render(request,'userinfo.html',{'userinfo': userInfo})



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
    results = {
        'online_user':  online_user,
    }
    return render(request, 'accounts/user_online_list.html', results)


@login_required()
def user_list(request):
    all_user = get_user_model().objects.all()
    results = {
        'all_user':  all_user,
    }
    return render(request, 'accounts/user_list.html', results)


@login_required
def user_add(request):
    if request.method == 'POST':
        form = AddUserForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.set_password(form.cleaned_data['password'])
            form.save()
            return HttpResponseRedirect(reverse('user_list'))
    else:
        form = AddUserForm()
    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'accounts/user_add.html', results)


@login_required
def user_del(request, ids):
    if ids:
        get_user_model().objects.filter(id=ids).delete()
    return HttpResponseRedirect(reverse('user_list'))



@login_required
def user_edit(request, ids):
    user = get_user_model().objects.get(id=ids)
    if request.method == 'POST':
        form = EditUserForm(request.POST, instance=user)
        if form.is_valid():
            form.save()
            status = 1
        else:
            status = 2
    else:
        form = EditUserForm(instance=user)
    return render(request, 'accounts/user_edit.html', locals())


@login_required
def reset_password(request, ids):
    user = get_user_model().objects.get(id=ids)
    newpassword = get_user_model().objects.make_random_password(length=10, allowed_chars='abcdefghjklmnpqrstuvwxyABCDEFGHJKLMNPQRSTUVWXY0123456789,.?!@#$%^&*')
    user.set_password(newpassword)
    user.save()
    results = {
        'object': user,
        'newpassword': newpassword,
        'request': request,
    }
    return render(request, 'accounts/reset_password.html', results)


@login_required
def change_password(request):
    if request.method == 'POST':
        form = ChangePasswordForm(user=request.user, data=request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('logout'))
    else:
        form = ChangePasswordForm(user=request.user)
    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'accounts/change_password.html', results)

