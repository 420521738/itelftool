#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render, HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from accounts.permission import permission_verify
from fast_excute.models import Fastexcude
from fast_excute.models import FastexcudeRecord
from fast_excute.forms import FastexcudeFrom
from fast_excute.tasks import deploy
import json
import time
import os
import datetime
from django.utils import timezone
import csv


# 导出excel，csv所需要转换中文字符
def str2gb(args):
    """
    :参数 args:
    :返回: GB2312编码
    """
    #return str(args).encode('gb2312')
    return str(args)


# 项目上线列表
@login_required()
@permission_verify()
def coderelease(request):
    all_project = []
    all_project = Fastexcude.objects.all()
    results = {
        'all_project': all_project,
        'request': request,
    }
    return render(request, 'fast_excude/coderelease_list.html', results)


# 项目添加
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


# 项目执行状态查询
@login_required()
@permission_verify()
def coderelease_status(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    bar_data = project.bar_data
    status_val = project.status
    ret = {"bar_data": bar_data, "status": status_val}
    # This 将数据序列花再返回给列表页的js进行处理和使用
    data = json.dumps(ret)
    return HttpResponse(data)


# 项目编辑
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


# 项目删除
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


# 项目执行
@login_required
@permission_verify()
def coderelease_deploy(request, project_id):
    excudeuser = request.user.name
    project = Fastexcude.objects.get(id=project_id)
    # This 前端页面点击执行后，将进度条长度设置为10px，这个进度只要设置合理，长度多少没关系
    project.bar_data = 10
    name = project.name
    serverip = project.server.ipaddr
    # This 前端页面点击执行后，设置status为True，因为默认是Flase是不在执行
    project.status = True
    #project.excude_time = datetime.datetime.now()
    excudetime = datetime.datetime.now()
    project.excude_time = excudetime
    project.save()
    time.sleep(2)
    os.system("mkdir -p /var/opt/itelftool/fastexcute/workspace/{0}/logs".format(name))
    project.bar_data = 15
    project.save()
    # This 调用deploy去执行这个任务
    # This 其中name，serverip，excudetime，excudeuser 都是执行艘需要记录的字段，所以把这些字段传给deploy，等执行完成或者执行失败后就进行记录
    deploy(name, serverip, project_id, excudetime, excudeuser)
    return HttpResponse("ok")


# 项目停止
@login_required()
@permission_verify()
def coderelease__stop(request, project_id):
    project = Fastexcude.objects.get(id=project_id)
    
    # This 执行信息记录
    excudeuser = request.user.name
    excudetime = datetime.datetime.now()
    name = project.name
    serverip = project.server.ipaddr
    # This 这个是执行记录，如果是被终止的，就不写日志信息，以防读取到上一次执行的日志
    FastexcudeRecord.objects.create(excudename=name, excudeuser=excudeuser, excudeserver=serverip, excude_time=excudetime, excudestatus=False)
    
    # This 执行被终止，就当作执行失败
    project.bar_data = 99
    project.status = False
    project.save()
    
    return HttpResponse("上线任务终止成功！")


# 项目查看日志中间人功能
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


# 日志实时显示功能
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


# 执行记录展示
@login_required
@permission_verify()
def coderelease_record(request):
    all_records = FastexcudeRecord.objects.all().order_by('-excude_time')
    results = {
        'all_records':  all_records,
    }
    return render(request, 'fast_excude/coderelease_records.html', results)


# 执行记录导出
@login_required
@permission_verify()
def coderelease_record_export(request):
    export = request.GET.get("export", '')
    coderelease_record_id_list = request.GET.getlist("id", '')
    if export == "part":
        if coderelease_record_id_list:
            coderelease_record_find = []
            for coderelease_record_id in coderelease_record_id_list:
                coderelease_record_item = FastexcudeRecord.objects.get(id=coderelease_record_id)
                if coderelease_record_item:
                    coderelease_record_find.append(coderelease_record_item)

    if export == "all":
        coderelease_record_find = FastexcudeRecord.objects.all()

    response = HttpResponse(content_type='text/csv')
    now = datetime.datetime.now().strftime('%Y_%m_%d_%H_%M')
    file_name = 'FastExcudeRrecord_' + now + '.csv'
    response['Content-Disposition'] = "attachment; filename="+file_name
    writer = csv.writer(response, dialect='excel')
    writer.writerow([str2gb(u'执行项目名'), str2gb(u'执行结果'), str2gb(u'执行人'), str2gb(u'执行服务器'), str2gb(u'执行时间'), ])
    for coderelease_record in coderelease_record_find:
        # This 判断执行状态的值，才能定义执行成功或者失败的中文字符
        if coderelease_record.excudestatus:
            excudestatus = '成功'
        else:
            excudestatus = '失败'
        writer.writerow([str2gb(coderelease_record.excudename), str2gb(excudestatus), str2gb(coderelease_record.excudeuser), coderelease_record.excudeserver, timezone.localtime(coderelease_record.excude_time).strftime("%Y-%m-%d %H:%M:%S") ])
    return response


# 每次更新的执行过程详情查看
# 这里的codereleaserecord_id，与fast_excute里面的url中的变量需要相同
@login_required
@permission_verify()
def coderelease_logdetail(request, codereleaserecord_id):
    codereleaserecord = FastexcudeRecord.objects.get(id=codereleaserecord_id)
    results = {
        'codereleaserecord':  codereleaserecord,
    }
    return render(request, 'fast_excude/coderelease_logdetail.html', results)


