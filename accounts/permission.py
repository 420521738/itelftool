#!/usr/bin/env python
# -*- coding: utf-8 -*-
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from accounts.forms import PermissionListForm
from accounts.models import RoleList, PermissionList
from assets.models import UserProfile



# 权限判断装饰器
def permission_verify():
    """
        权限认证模块,
        此模块会先判断用户是否是管理员（is_superuser为True），如果是管理员，则具有所有权限,
        如果不是管理员则获取request.user和request.path两个参数，判断两个参数是否匹配，匹配则有权限，反之则没有。
    """
    def decorator(view_func):
        def _wrapped_view(request, *args, **kwargs):
            iUser = UserProfile.objects.get(email=request.user)
            # 判断用户如果是超级管理员则具有所有权限
            if not iUser.is_superuser:
                if not iUser.role:  # 如果用户无角色，直接返回无权限
                    return HttpResponseRedirect(reverse('permission_deny'))

                role_permission = RoleList.objects.get(name=iUser.role)
                role_permission_list = role_permission.permission.all()

                matchUrl = []
                for x in role_permission_list:
                    # 精确匹配，判断request.path是否与permission表中的某一条相符,rstrip作用是删除字符串末尾的指定字符
                    if request.path == x.url or request.path.rstrip('/') == x.url:
                        matchUrl.append(x.url)
                    # 判断request.path是否以permission表中的某一条url开头
                    elif request.path.startswith(x.url):
                        matchUrl.append(x.url)
                    else:
                        pass

                print('{}---->matchUrl:{}'.format(request.user, str(matchUrl)))
                if len(matchUrl) == 0:
                    return HttpResponseRedirect(reverse('permission_deny'))
            else:
                pass

            return view_func(request, *args, **kwargs)
        return _wrapped_view
    return decorator



# 权限列表功能，说白了就是一个个url或者一组url
@login_required
@permission_verify()
def permission_list(request):
    all_permission = PermissionList.objects.all()
    results = {
        'all_permission':  all_permission,
    }
    return render(request, 'accounts/permission_list.html', results)


# 增加权限功能，其实就是增加url的限制
@login_required
@permission_verify()
def permission_add(request):
    if request.method == "POST":
        form = PermissionListForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('permission_list'))
    else:
        form = PermissionListForm()

    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'accounts/permission_add.html', results)


# 权限编辑功能
@login_required
@permission_verify()
def permission_edit(request, ids):
    iPermission = PermissionList.objects.get(id=ids)

    if request.method == "POST":
        form = PermissionListForm(request.POST, instance=iPermission)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('permission_list'))
    else:
        form = PermissionListForm(instance=iPermission)

    results = {
        'ids': ids,
        'form': form,
        'request': request,
    }
    return render(request, 'accounts/permission_edit.html', results)


# 权限删除功能
@login_required
@permission_verify()
def permission_del(request, ids):
    PermissionList.objects.filter(id=ids).delete()
    return HttpResponseRedirect(reverse('permission_list'))


# 如果加了权限判断的装饰器，判断无权限的话，就会执行这个权限拒绝功能，也就是返回一个无权限告知页面
@login_required
def permission_deny(request):
    results = {
        'request': request,
    }
    return render(request, 'accounts/permission_deny.html', results)

