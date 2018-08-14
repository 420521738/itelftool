#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from appconf.models import Product, Project, AppOwner
from django.shortcuts import render, HttpResponseRedirect, HttpResponse
from appconf.forms import ProductForm, ProjectForm, AppOwnerForm
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
def product_list(request):
    all_product = Product.objects.all()
    results = {
        'all_product':  all_product,
    }
    return render(request, 'appconf/product_list.html', results)


@login_required
def product_add(request):
    if request.method == 'POST':
        form = ProductForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('product_list'))
    else:
        form = ProductForm()

    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'appconf/product_base.html', results)


@login_required
def product_edit(request, product_id):
    product = Product.objects.get(id=product_id)
    if request.method == 'POST':
        form = ProductForm(request.POST, instance=product)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('product_list'))
    else:
        form = ProductForm(instance=product)

    results = {
        'form': form,
        'product_id': product_id,
        'request': request,
    }
    return render(request, 'appconf/product_base.html', results)


@login_required
def product_del(request):
    product_id = request.GET.get('id', '')
    if product_id:
        Product.objects.filter(id=product_id).delete()

    product_id_all = str(request.POST.get('product_id_all', ''))
    if product_id_all:
        for product_id in product_id_all.split(','):
            Product.objects.filter(id=product_id).delete()

    return HttpResponseRedirect(reverse('product_list'))


@login_required
def project_list(request, product_id):
    product = Product.objects.get(id=product_id)
    projects = product.project_set.all()
    results = {
        'project_list':  projects,
    }
    return render(request, 'appconf/product_project_list.html', results)


@login_required
def project_projectlist(request):
    all_project = Project.objects.all()
    results = {
        'all_project':  all_project,
    }
    return render(request, 'appconf/project_list.html', results)


@login_required
def project_add(request):
    if request.method == 'POST':
        form = ProjectForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('project_list'))
    else:
        form = ProjectForm()

    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'appconf/project_base.html', results)


@login_required
def project_edit(request, project_id):
    project = Project.objects.get(id=project_id)
    if request.method == 'POST':
        form = ProjectForm(request.POST, instance=project)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('project_list'))
    else:
        form = ProjectForm(instance=project)

    results = {
        'form': form,
        'project_id': project_id,
        'request': request,
    }
    return render(request, 'appconf/project_base.html', results)


@login_required
def project_del(request):
    project_id = request.GET.get('project_id', '')
    if project_id:
        Project.objects.filter(id=project_id).delete()

    project_id_all = str(request.POST.get('project_id_all', ''))
    if project_id_all:
        for project_id in project_id_all.split(','):
            Project.objects.filter(id=project_id).delete()

    return HttpResponseRedirect(reverse('project_list'))


@login_required
def project_export(request):
    export = request.GET.get("export", '')
    project_id_list = request.GET.getlist("id", '')
    if export == "part":
        if project_id_list:
            project_find = []
            for project_id in project_id_list:
                project_item = Project.objects.get(id=project_id)
                if project_item:
                    project_find.append(project_item)

    if export == "all":
        project_find = Project.objects.all()

    response = HttpResponse(content_type='text/csv')
    now = datetime.datetime.now().strftime('%Y_%m_%d_%H_%M')
    file_name = 'itelftool_project_' + now + '.csv'
    response['Content-Disposition'] = "attachment; filename="+file_name
    writer = csv.writer(response, dialect='excel')
    writer.writerow([str2gb(u'项目名称'), str2gb(u'项目描述'), str2gb(u'语言类型'), str2gb(u'程序类型'),
                     str2gb(u'服务器类型'), str2gb(u'程序框架'), str2gb(u'源类型'), str2gb(u'源地址'),
                     str2gb(u'程序部署路径'), str2gb(u'配置文件路径'),
                     str2gb(u'所属产品线'), str2gb(u'项目负责人'), str2gb(u'服务器')])
    for p in project_find:
        server_array = p.serverList
        server_result = ""
        for server in p.serverList.all():
            server_result += server.name+"\n"
        writer.writerow([str2gb(p.name), str2gb(p.description), p.language_type, p.app_type, p.server_type,
                        p.app_arch, p.source_type, p.source_address, p.appPath, p.configPath, str2gb(p.product),
                         str2gb(p.owner), str2gb(server_result)])
    return response


@login_required
def appowner_list(request):
    all_app_owner = AppOwner.objects.all()
    results = {
        'all_app_owner':  all_app_owner,
    }
    return render(request, 'appconf/appowner_list.html', results)


@login_required
def appowner_add(request):
    if request.method == 'POST':
        form = AppOwnerForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('appowner_list'))
    else:
        form = AppOwnerForm()

    results = {
        'form': form,
        'request': request,
        'page_type': "whole"
    }
    return render(request, 'appconf/appowner_add_edit.html', results)


@login_required
def appowner_edit(request, appowner_id, mini=False):
    appowner = AppOwner.objects.get(id=appowner_id)
    if request.method == 'POST':
        form = AppOwnerForm(request.POST, instance=appowner)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('appowner_list'))
    else:
        form = AppOwnerForm(instance=appowner)

    results = {
        'form': form,
        'appowner_id': appowner_id,
        'request': request,
        'page_type': "whole"
    }
    return render(request, 'appconf/appowner_add_edit.html', results)



@login_required
def appowner_del(request):
    appowner_id = request.GET.get('id', '')
    if appowner_id:
        AppOwner.objects.filter(id=appowner_id).delete()

    appowner_id_all = str(request.POST.get('appowner_id_all', ''))
    if appowner_id_all:
        for appowner_id in appowner_id_all.split(','):
            AppOwner.objects.filter(id=appowner_id).delete()

    return HttpResponseRedirect(reverse('appowner_list'))


@login_required
def appowner_add_mini(request):
    status = 0
    owner_id = 0
    if request.method == 'POST':
        form = AppOwnerForm(request.POST)
        if form.is_valid():
            form.save()
            owner_name = request.POST.get('name', '')
            app_owner = AppOwner.objects.get(name=owner_name)
            owner_id = app_owner.id
            status = 1
        else:
            status = 2
    else:
        form = AppOwnerForm()

    results = {
        'form': form,
        'request': request,
        'status': status,
        'owner_id': owner_id,
        'owner_name': request.POST.get('name', ''),
        'page_type': "mini"
    }
    return render(request, 'appconf/appowner_add_edit_mini.html', results)






















