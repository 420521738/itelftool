#!/usr/bin/env python
#coding:utf-8

from django.shortcuts import render
from django.contrib.auth.decorators import login_required



@login_required
def webshell(request):
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

@login_required
def serverlist(request):
    return render(request, 'webshell/serverlist.html')