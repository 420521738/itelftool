#!/usr/bin/env python
#coding:utf-8

from django.shortcuts import render, HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import login_required
from webshell.models import webshell
from webshell.forms import WebshellForm, WebshellFormServerLogin
from accounts.permission import permission_verify


# 这个是在webshell首页上的一键登录时所使用的函数，传过来的id是服务器id
@login_required
@permission_verify()
def shell_terminal(request, ids):
    issh = webshell.objects.get(id=ids)
    ipaddr = issh.ipaddr
    username = issh.username
    password = issh.password
    port = int(issh.port)
    serverinfo = {'ipaddr':ipaddr, 'port':port, 'username':username, 'password':password}
    results = {
        'serverinfo':  serverinfo,
     }
    return render(request, 'webshell/webshell.html', results)


# 这个是webshell首页，会展示已经添加的一键登录的服务器
@login_required
@permission_verify()
def ssh_list(request):
    all_sshlist = webshell.objects.all()
    results = {
        'all_sshlist':  all_sshlist,
    }
    return render(request, 'webshell/ssh_list.html', results)


# 这个是webshell首页上添加登录服务器的功能
@login_required
@permission_verify()
def ssh_add(request):
    if request.method == 'POST':
        form = WebshellForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('ssh_list'))
    else:
        form = WebshellForm()
    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'webshell/ssh_add.html', results)


# 这个是webshell首页上编辑登录服务器的功能
@login_required
@permission_verify()
def ssh_edit(request, ids):
    issh = webshell.objects.get(id=ids)
    if request.method == 'POST':
        form = WebshellForm(request.POST, instance=issh)
        if form.is_valid():
            form.save()
            status = 1
        else:
            status = 2
    else:
        form = WebshellForm(instance=issh)
    return render(request, 'webshell/ssh_edit.html', locals())


# 这个是webshell首页上删除已添加的服务器功能
@login_required
@permission_verify()
def ssh_del(request, ids):
    webshell.objects.filter(id=ids).delete()
    return HttpResponseRedirect(reverse('ssh_list'))


# 这个是webshell功能里，通过帐号密码方式登录服务器的输入功能页面
@login_required
@permission_verify()
def server_login(request):
    form = WebshellFormServerLogin()
    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'webshell/server_login.html', results)


# 这个是通过帐号密码方式登录服务器的接口功能
@login_required
@permission_verify()
def shell_terminal_server_login(request):
    if request.method == "POST":
        ipaddr = request.POST.get('ipaddr')
        port = int(request.POST.get('port'))
        username = request.POST.get('username')
        password = request.POST.get('password')
        serverinfo = {'ipaddr':ipaddr, 'port':port, 'username':username, 'password':password}
    results = {
        'serverinfo':  serverinfo,
     }
    return render(request, 'webshell/webshell.html', results)

