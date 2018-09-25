#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render, HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from accounts.permission import permission_verify
from fast_excute.models import Fastexcude
from lib.tools import pages
from fast_excute.forms import FastexcudeFrom
from fast_excute.tasks import deploy
import json
import time
import os
import datetime


@login_required()
@permission_verify()
def coderelease(request):
    all_project = []
    all_project = Fastexcude.objects.all()
    project_list, p, projects, page_range, current_page, show_first, show_end, end_page = pages(all_project, request)
    return render(request, 'fast_excude/coderelease_list.html', locals())



@login_required
@permission_verify()
def coderelease_add(request):
    if request.method == 'POST':
        form = FastexcudeFrom(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('coderelease'))
    else:
        form = FastexcudeFrom()

    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'fast_excude/coderelease_base.html', results)


@login_required()
@permission_verify()
def coderelease_status(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    bar_data = project.bar_data
    status_val = project.status
    ret = {"bar_data": bar_data, "status": status_val}
    data = json.dumps(ret)
    return HttpResponse(data)



@login_required
@permission_verify()
def coderelease_edit(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    if request.method == 'POST':
        form = FastexcudeFrom(request.POST, instance=project)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('coderelease'))
    else:
        form = FastexcudeFrom(instance=project)

    results = {
        'form': form,
        'project_id': project_id,
        'request': request,
    }
    return render(request, 'fast_excude/coderelease_base.html', results)


@login_required
@permission_verify()
def coderelease_del(request):
    project_id = request.GET.get('project_id', '')
    if project_id:
        Fastexcude.objects.filter(id=project_id).delete()

    project_id_all = str(request.POST.get('project_id_all', ''))
    if project_id_all:
        for project_id in project_id_all.split(','):
            Fastexcude.objects.filter(id=project_id).delete()

    return HttpResponseRedirect(reverse('coderelease'))




@login_required
@permission_verify()
def coderelease_deploy(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    project.bar_data = 10
    name = project.name
    serverip = project.server.ipaddr
    project.status = True
    project.excude_time = datetime.datetime.now()
    project.save()
    time.sleep(2)
    os.system("mkdir -p /var/opt/itelftool/fastexcute/workspace/{0}/logs".format(name))
    project.bar_data = 15
    project.save()
    deploy(name, serverip, project_id)
    return HttpResponse("ok")


@login_required()
@permission_verify()
def coderelease__stop(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    project.bar_data = 0
    project.status = False
    project.save()
    return HttpResponse("上线任务终止成功！")



@login_required()
@permission_verify()
def coderelease_log(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    results = {
        'project': project,
        'project_id': project_id,
        'request': request,
    }
    return render(request, "fast_excude/coderelease_results.html", results)


@login_required()
@permission_verify()
def coderelease_log2(request, project_id):
    ret = []
    project = Fastexcude.objects.get(id=project_id)
    name = project.name
    try:
        job_workspace = "/var/opt/itelftool/fastexcute/workspace/{0}/".format(name)
        log_file = job_workspace + 'logs/deploy.log'
        with open(log_file, 'r') as f:
            line = f.readlines()
        for l in line:
            a = l + "<br>"
            ret.append(a)
    except IOError:
        ret = "正在读取日志，请稍等...<br>"
    return HttpResponse(ret)
