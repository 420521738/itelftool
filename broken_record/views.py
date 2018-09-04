#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render, HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from broken_record.models import BrokenRrecord
from broken_record.forms import BrokenRrecordForm
from django.core.urlresolvers import reverse
import csv
import datetime


def str2gb(args):
    """
    :参数 args:
    :返回: GB2312编码
    """
    #return str(args).encode('gb2312')
    return str(args)


@login_required
def brokenrecord_list(request):
    all_brokenrecord = BrokenRrecord.objects.all()
    results = {
        'all_brokenrecord':  all_brokenrecord,
    }
    return render(request, 'broken_record/broken_record_list.html', results)


@login_required
def brokenrecord_add(request):
    if request.method == 'POST':
        form = BrokenRrecordForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('brokenrecord'))
    else:
        form = BrokenRrecordForm()

    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'broken_record/brokenrecord_base.html', results)


@login_required
def brokenrecord_edit(request, brokenrecord_id):
    brokenrecord = BrokenRrecord.objects.get(id=brokenrecord_id)
    if request.method == 'POST':
        form = BrokenRrecordForm(request.POST, instance=brokenrecord)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('brokenrecord'))
    else:
        form = BrokenRrecordForm(instance=brokenrecord)

    results = {
        'form': form,
        'brokenrecord_id': brokenrecord_id,
        'request': request,
    }
    return render(request, 'broken_record/brokenrecord_base.html', results)


@login_required
def brokenrecord_del(request):
    brokenrecord_id = request.GET.get('id', '')
    if brokenrecord_id:
        BrokenRrecord.objects.filter(id=brokenrecord_id).delete()

    brokenrecord_id_all = str(request.POST.get('brokenrecord_id_all', ''))
    if brokenrecord_id_all:
        for brokenrecord_id in brokenrecord_id_all.split(','):
            BrokenRrecord.objects.filter(id=brokenrecord_id).delete()

    return HttpResponseRedirect(reverse('brokenrecord'))


@login_required
def brokenrecord_detail(request, brokenrecord_id):
    brokenrecord = BrokenRrecord.objects.get(id=brokenrecord_id)
    results = {
        'brokenrecord':  brokenrecord,
    }
    return render(request, 'broken_record/broken_record_detail.html', results)


@login_required
def brokenrecord_export(request):
    export = request.GET.get("export", '')
    brokenrecord_id_list = request.GET.getlist("id", '')
    if export == "part":
        if brokenrecord_id_list:
            brokenrecord_find = []
            for brokenrecord_id in brokenrecord_id_list:
                brokenrecord_item = BrokenRrecord.objects.get(id=brokenrecord_id)
                if brokenrecord_item:
                    brokenrecord_find.append(brokenrecord_item)

    if export == "all":
        brokenrecord_find = BrokenRrecord.objects.all()

    response = HttpResponse(content_type='text/csv')
    now = datetime.datetime.now().strftime('%Y_%m_%d_%H_%M')
    file_name = 'BrokenRrecord_' + now + '.csv'
    response['Content-Disposition'] = "attachment; filename="+file_name
    writer = csv.writer(response, dialect='excel')
    writer.writerow([str2gb(u'故障名称'), str2gb(u'故障描述'), str2gb(u'故障主要归属部门'), str2gb(u'运维主要处理人'),
                     str2gb(u'开发主要处理人'), str2gb(u'故障类型'), str2gb(u'故障严重性'), str2gb(u'故障状态类型'),
                     str2gb(u'所属产品线'), str2gb(u'所属项目'),str2gb(u'处理过程'), str2gb(u'预防措施'), 
                     str2gb(u'故障发生时间'), str2gb(u'故障结束时间'), str2gb(u'业务影响时间'), str2gb(u'记录更新日期'), ])
    for broken_record in brokenrecord_find:
        writer.writerow([str2gb(broken_record.name), str2gb(broken_record.description), str2gb(broken_record.broken_department), str2gb(broken_record.maintenance),
                         str2gb(broken_record.developer), str2gb(broken_record.broken_type), str2gb(broken_record.severity_type),str2gb(broken_record.broken_status_type),
                         str2gb(broken_record.product), str2gb(broken_record.project), str2gb(broken_record.process_description),str2gb(broken_record.precaution),
                         broken_record.occur_time, broken_record.end_time, str2gb(broken_record.business_impact_time), broken_record.update_date])
    return response
