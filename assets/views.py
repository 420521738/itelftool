#!/usr/bin/env python
#coding:utf-8

from django.shortcuts import render, HttpResponse
from assets import core, models, asset_handle, utils, admin
import json
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.core.exceptions import ObjectDoesNotExist
from assets import tables
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from assets.dashboard import  AssetDashboard
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect
from assets.forms import IdcForm, CabinetForm, GroupForm
from assets.models import IDC,Cabinet, HostGroup



@login_required
def index(request):
    return render(request, 'index.html')


# 其中 utils.token_required装饰器为接口认证，这个认证与客户端的认证是一致的才能进行函数执行的操作
@csrf_exempt
@utils.token_required
def asset_report(request):
    #print('后端收到前端数据：',request.GET)
    #print('后端收到前端数据：',request.POST)
    if request.method == 'POST':
        ass_handler = core.Asset(request)
        if ass_handler.data_is_valid():
            print("----asset data valid:")
            ass_handler.data_inject()
            # return HttpResponse(json.dumps(ass_handler.response))

        return HttpResponse(json.dumps(ass_handler.response))
        # return render(request,'assets/asset_report_test.html',{'response':ass_handler.response})
        # else:
        # return HttpResponse(json.dumps(ass_handler.response))

    return HttpResponse('--test--')


@csrf_exempt
def asset_with_no_asset_id(request):
    if request.method == 'POST':
        ass_handler = core.Asset(request)
        res = ass_handler.get_asset_id_by_sn()

        # return render(request,'assets/acquire_asset_id_test.html',{'response':res})
        return HttpResponse(json.dumps(res))


def new_assets_approval(request):
    if request.method == 'POST':
        request.POST = request.POST.copy()
        approved_asset_list = request.POST.getlist('approved_asset_list')
        approved_asset_list = models.NewAssetApprovalZone.objects.filter(id__in=approved_asset_list)

        response_dic = {}
        for obj in approved_asset_list:
            request.POST['asset_data'] = obj.data
            ass_handler = core.Asset(request)
            if ass_handler.data_is_valid_without_id():
                ass_handler.data_inject()
                obj.approved = True
                obj.save()

            response_dic[obj.id] = ass_handler.response
        return render(request, 'assets/new_assets_approval.html',
                      {'new_assets': approved_asset_list, 'response_dic': response_dic})
    else:
        ids = request.GET.get('ids')
        id_list = ids.split(',')
        new_assets = models.NewAssetApprovalZone.objects.filter(id__in=id_list)
        return render(request, 'assets/new_assets_approval.html', {'new_assets': new_assets})


def asset_report_test(request):
    return render(request, 'assets/asset_report_test.html')


@login_required
def acquire_asset_id_test(request):
    return render(request, 'assets/acquire_asset_id_test.html')


# 资产列表页，资产列表展示
@login_required
def asset_list(request):
    # 获取资产，tables的table_filter函数就是用来找出过滤条件，筛选出对应资产
    asset_obj_list = tables.table_filter(request, admin.AssetAdmin, models.Asset)
    #print("asset_obj_list:", asset_obj_list)
    # asset_obj_list 是类似于 [<Asset: <id:15 name:TestServer>>, <Asset: <id:16 name:Ubuntu>>] 
    # 排序的结果
    order_res = tables.get_orderby(request, asset_obj_list, admin.AssetAdmin)
    # 翻页，list_per_page每页多少条数据
    paginator = Paginator(order_res[0], admin.AssetAdmin.list_per_page)
    # 从请求中获取到的页码，客户请求的是第几页
    page = request.GET.get('page')
    try:
        asset_objs = paginator.page(page)
    except PageNotAnInteger:
        asset_objs = paginator.page(1)
    except EmptyPage:
        asset_objs = paginator.page(paginator.num_pages)

    # table_obj就是页面所需要展示的数据
    table_obj = tables.TableHandler(request,
                                    models.Asset,
                                    admin.AssetAdmin,
                                    asset_objs,
                                    order_res
                                    )

    return render(request, 'assets/assets.html', {'table_obj': table_obj,
                                                  'paginator': paginator})


@login_required
def get_asset_list(request):
    asset_dic = asset_handle.fetch_asset_list()
    print(asset_dic)

    return HttpResponse(json.dumps(asset_dic, default=utils.json_date_handler))


@login_required
def asset_category(request):
    category_type = request.GET.get("category_type")
    if not category_type: category_type = 'server'
    if request.is_ajax():
        categories = asset_handle.AssetCategroy(request)
        data = categories.serialize_data()
        return HttpResponse(data)
    else:
        return render(request, 'assets/asset_category.html', {'category_type': category_type})


@login_required
def asset_event_logs(request, asset_id):
    if request.method == "GET":
        log_list = asset_handle.fetch_asset_event_logs(asset_id)
        return HttpResponse(json.dumps(log_list, default=utils.json_datetime_handler))


@login_required
def asset_detail(request, asset_id):
    if request.method == "GET":
        try:
            asset_obj = models.Asset.objects.get(id=asset_id)

        except ObjectDoesNotExist as e:
            return render(request, 'assets/asset_detail.html', {'error': e})
        return render(request, 'assets/asset_detail.html', {"asset_obj": asset_obj})


# 这里是从index.html页面过来拿数据的
@login_required
def get_dashboard_data(request):
    '''返回主页面数据'''
    # 继承类 AssetDashboard
    dashboard_data = AssetDashboard(request)
    # 调用类 AssetDashboard下的searilize_page方法
    dashboard_data.searilize_page()
    return HttpResponse(json.dumps(dashboard_data.data))


@login_required
def event_center(request):
    '''事件中心'''
    
    # 返回事件event。tables.table_filter函数已经帮你找出过滤条件，并且根据过滤条件到models.EventLog去获取到了数据
    eventlog_objs = tables.table_filter(request, admin.EventLogAdmin, models.EventLog)
    # 排序之后的结果
    order_res = tables.get_orderby(request, eventlog_objs, admin.EventLogAdmin)
    # 分页，每页100条数据展示
    paginator = Paginator(order_res[0], admin.EventLogAdmin.list_per_page)

    page = request.GET.get('page')
    try:
        objs = paginator.page(page)
    except PageNotAnInteger:
        objs = paginator.page(1)
    except EmptyPage:
        objs = paginator.page(paginator.num_pages)

    table_obj = tables.TableHandler(request,
                                    models.EventLog,
                                    admin.EventLogAdmin,
                                    objs,
                                    order_res
                                    )


    return render(request,'assets/event_center.html',{'table_obj': table_obj,
                                                  'paginator': paginator})
    

@login_required()
def idc(request):
    idc_info = models.IDC.objects.all()
    return render(request, 'assets/idc.html', locals())


@login_required()
def idc_add(request):
    if request.method == "POST":
        idc_form = IdcForm(request.POST)
        if idc_form.is_valid():
            idc_form.save()
            tips = u"增加成功！"
            display_control = ""
        else:
            tips = u"增加失败！"
            display_control = ""
        return render(request, "assets/idc_base.html", locals())
    else:
        display_control = "none"
        idc_form = IdcForm()
        return render(request, "assets/idc_base.html", locals())

@login_required()
def idc_del(request):
    idc_id = request.GET.get('id', '')
    if idc_id:
        IDC.objects.filter(id=idc_id).delete()
    if request.method == 'POST':
        idc_items = request.POST.getlist('idc_check', [])
        if idc_items:
            for n in idc_items:
                IDC.objects.filter(id=n).delete()
    idc_info = IDC.objects.all()
    return render(request, "assets/idc.html", locals())

@login_required()
def idc_edit(request, idc_id):
    project = IDC.objects.get(id=idc_id)
    if request.method == 'POST':
        form = IdcForm(request.POST, instance=project)
        if form.is_valid():
            form.save()
            # HttpResponseRedirect(reverse('idc'))是重定向的方法，跳转到name为idc的url中去
            return HttpResponseRedirect(reverse('idc'))
    else:
        form = IdcForm(instance=project)
    display_control = "none"
    results = {
        'idc_form': form,
        'idc_id': idc_id,
        'request': request,
        'display_control': display_control,
    }
    return render(request, 'assets/idc_base.html', results)

@login_required()
def cabinet_list(request, cabinet_id):
    cab = IDC.objects.get(id=cabinet_id)
    cabinets = cab.cabinet_set.all()
    results = {
        'cabinet_list':  cabinets,
    }
    return render(request, 'assets/idc_cabinet_list.html', results)


@login_required()
def cabinet(request):
    allcabinet = Cabinet.objects.all()
    context = {
        'allcabinet': allcabinet
    }
    return render(request, 'assets/cabinet.html', context)


@login_required()
def cabinet_add(request):
    if request.method == "POST":
        cabinet_form = CabinetForm(request.POST)
        if cabinet_form.is_valid():
            cabinet_form.save()
            tips = u"增加成功！"
            display_control = ""
        else:
            tips = u"增加失败！"
            display_control = ""
        return render(request, "assets/cabinet_base.html", locals())
    else:
        display_control = "none"
        cabinet_form = CabinetForm()
        return render(request, "assets/cabinet_base.html", locals())


@login_required()
def cabinet_del(request):
    cabinet_id = request.GET.get('id', '')
    if cabinet_id:
        Cabinet.objects.filter(id=cabinet_id).delete()

    if request.method == 'POST':
        cabinet_items = request.POST.getlist('g_check', [])
        if cabinet_items:
            for n in cabinet_items:
                Cabinet.objects.filter(id=n).delete()
    allcabinet = Cabinet.objects.all()
    return render(request, "assets/cabinet.html", locals())


@login_required()
def cabinet_edit(request, cabinet_id):
    project = Cabinet.objects.get(id=cabinet_id)
    if request.method == 'POST':
        form = CabinetForm(request.POST, instance=project)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('cabinet'))
    else:
        form = CabinetForm(instance=project)
    display_control = "none"
    results = {
        'cabinet_form': form,
        'cabinet_id': cabinet_id,
        'request': request,
        'display_control': display_control,
    }
    return render(request, 'assets/cabinet_base.html', results)


@login_required
def server_list(request, cabinet_id):
    cab = Cabinet.objects.get(id=cabinet_id)
    servers = cab.serverList.all()
    serverlist = []
    for server in servers:
        obj = models.Asset.objects.get(id=server.id)
        serverlist.append(server)
    return render(request, 'assets/cabinet_server_list.html', {'serverlist':serverlist})


@login_required
def group(request):
    allgroup = HostGroup.objects.all()
    context = {
        'allgroup': allgroup
    }
    return render(request, 'assets/group.html', context)


@login_required
def group_add(request):
    if request.method == "POST":
        group_form = GroupForm(request.POST)
        if group_form.is_valid():
            group_form.save()
            tips = u"增加成功！"
            display_control = ""
        else:
            tips = u"增加失败！"
            display_control = ""
        return render(request, "assets/group_base.html", locals())
    else:
        display_control = "none"
        group_form = GroupForm()
        return render(request, "assets/group_base.html", locals())


@login_required
def group_edit(request, group_id):
    project = HostGroup.objects.get(id=group_id)
    if request.method == 'POST':
        form = GroupForm(request.POST, instance=project)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('group'))
    else:
        form = GroupForm(instance=project)
    display_control = "none"
    results = {
        'group_form': form,
        'group_id': group_id,
        'request': request,
        'display_control': display_control,
    }
    return render(request, 'assets/group_base.html', results)


@login_required
def group_del(request):
    group_id = request.GET.get('id', '')
    if group_id:
        HostGroup.objects.filter(id=group_id).delete()
    if request.method == 'POST':
        group_items = request.POST.getlist('g_check', [])
        if group_items:
            for n in group_items:
                HostGroup.objects.filter(id=n).delete()
    allgroup = HostGroup.objects.all()
    return render(request, "assets/group.html", locals())


@login_required
def groupserver_list(request, group_id):
    grp = HostGroup.objects.get(id=group_id)
    servers = grp.serverList.all()
    serverlist = []
    for server in servers:
        obj = models.Asset.objects.get(id=server.id)
        serverlist.append(server)
    return render(request, 'assets/group_server_list.html', {'serverlist':serverlist})



