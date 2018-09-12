#! /usr/bin/env python
# -*- coding: utf-8 -*-

from .models import navi
from django.shortcuts import render
from navi.forms import navi_form
from django.contrib.auth.decorators import login_required
from accounts.permission import permission_verify


@login_required()
@permission_verify()
def index(request):
    allnavi = navi.objects.all()
    return render(request, "navi/index.html", {'allnavi': allnavi})


@login_required()
@permission_verify()
def add(request):
    if request.method == "POST":
        # 如果请求的方法是post，那么则使用navi_form获取传送过来的数据，再判断数据是否合法
        n_form = navi_form(request.POST)
        if n_form.is_valid():
            n_form.save()
            tips = u"增加成功！"
            display_control = ""
        else:
            tips = u"增加失败！"
            display_control = ""
        # locals() 就是上述的变量都传到页面add.html上
        return render(request, "navi/add.html", locals())
    else:
        display_control = "none"
        # 如果不是post方法，那么则可能是get，就返回添加页面，n_form是表结构
        n_form = navi_form()
        return render(request, "navi/add.html", locals())


@login_required()
@permission_verify()
def delete(request):
    if request.method == 'POST':
        # 获取在站点编辑页选中的checkbox框的id，可能有多个，所以选择getlist
        navi_items = request.POST.getlist('navi_check', [])
        if navi_items:
            for n in navi_items:
                navi.objects.filter(id=n).delete()
    # 删除完后，获取数据库中的站点信息，返回站点编辑页
    allnavi = navi.objects.all()
    return render(request, "navi/manage.html", locals())


@login_required()
@permission_verify()
def manage(request):
    allnavi = navi.objects.all()
    return render(request, "navi/manage.html", {'allnavi': allnavi})


@login_required()
@permission_verify()
def edit(request):
    if request.method == 'GET':
        # id是js里tanchu function传过来的，将选中编辑的id传过来，并在数据库中获取该id的数据，传给edit.html页面
        item = request.GET.get("id")
        obj = navi.objects.get(id=item)
    return render(request, "navi/edit.html", locals())


@login_required()
@permission_verify()
def save(request):
    if request.method == 'POST':
        # 先获取从edit页面传过来的id，name,desc,url的值
        ids = request.POST.get('id')
        name = request.POST.get('name')
        desc = request.POST.get('desc')
        url = request.POST.get('url')
        # navi_item是从数据库中读取的对应id的数据
        navi_item = navi.objects.get(id=ids)
        # 针对该id的name，desc，url进行赋值，最后save到数据库
        navi_item.name = name
        navi_item.description = desc
        navi_item.url = url
        navi_item.save()
        # 如果保存成功，那么status状态值设置为1，保存不成功，则设置状态值为2
        status = 1
    else:
        status = 2
    allnavi = navi.objects.all()
    # 状态值返回到edit.html，有个js是根据这个状态值进行判断的
    return render(request, "navi/edit.html", locals())
