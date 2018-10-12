#!/usr/bin/env python
#coding:utf-8

from accounts.permission import permission_verify
from django.contrib.auth.decorators import login_required
import sys, os, shutil
import os.path
import datetime
import http.cookiejar
import urllib.request
import urllib.error
import urllib.parse
from django.http.response import HttpResponse,HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.shortcuts import render
from subprocess import Popen, PIPE
from zabbix.models import MonitorGraph
from zabbix.forms import GraphGroupForm
from urllib import parse
from zabbix.get_hostinfo import ZabbixAPI


class ZabbixGraph(object):
    def __init__(self, url, name, password):
        self.url = url
        self.name = name
        self.password = password
        cookiejar = http.cookiejar.CookieJar()
        urlOpener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cookiejar))
        values = {"name":self.name,'password':self.password,'autologin':1,"enter":'Sign in'}
        data = urllib.parse.urlencode(values).encode(encoding='UTF8')
        request = urllib.request.Request(url, data)
        try:
            urlOpener.open(request, timeout=10)
            self.urlOpener = urlOpener
        except urllib.error.HTTPError as e:
            print(e)

    def getgraph(self, url, values, image_dir):
        key = values.keys()
        if 'graphid' not in key:
            # print('请确认是否输入graphid')
            sys.exit(1)
        if 'period' not in key:
            values['period'] = 86400
        if 'stime' not in key:
            values['stime'] = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        if 'width' not in key:
            values["width"] = 800
        if 'height' not in key:
            values["height"] = 200

        # This values是图片的要素，根据图片的要素生成图片
        data = urllib.parse.urlencode(values).encode(encoding='UTF8')
        request = urllib.request.Request(url, data)
        url = self.urlOpener.open(request)
        image = url.read()
        # This 以图片的id命明图片，保存到image_dir目录下
        imagename = "%s/%s.png" % (image_dir, values["graphid"])
        f = open(imagename, 'wb')
        f.write(image)


# 这个是真正生成报表所需要图片的函数，很重要
# 有4个参数，第一个不多说，第二个是报表统计开始时间，第三个是结束时间，第五个是所选择的图片id列表
@login_required
@permission_verify()
def get_time_graph(request, starttime, endtime, ids):
    # This 这里的strftime是将时间从时间格式转为字符串格式，用户报表命名、报表内容替换
    start_time = starttime.strftime('%Y%m%d')
    s_time = starttime.strftime('%Y%m%d%H%M%S')
    end_time = endtime.strftime('%Y%m%d')
    
    # This 以下这一段是固定的，zabbix的web登录信息，用来模拟zabbix登录
    gr_url="http://21.2.48.67:16888/chart2.php"
    indexURL="http://21.2.48.67:16888/index.php"
    username = 'Admin'
    password = 'zabbix'
    
    # This 报表中所需要的图片的路径
    image_dir='/var/tmp/monitor/report/%s-%s/png/' % (start_time,end_time)
    
    # This 判断图片路径是否存在，如果存在，那就递归删除，然后创建
    if os.path.exists(image_dir):
        shutil.rmtree(image_dir)
    os.makedirs(image_dir)
    
    # 监控周期，按秒来算，生成图片的必须要素之一
    period = int((endtime-starttime).total_seconds())
    
    # 实例化b，并传入zabbix相关信息，ZabbixGraph的构造函数（__init__()）会进行登录验证以及模拟登录操作
    b=ZabbixGraph(indexURL,username,password)
    for id in ids:
        graph_name = 'value_%s' % id
        # This 创建一个图片所需要的要素，图片id，图片数据周期，图片数据开始时间，图片长度、图片宽度
        graph_name = {"graphid":id,"period":period,"stime":s_time,"width":800,"height":200}
        # This 调用ZabbixGraph的getgraph方法
        b.getgraph(gr_url, graph_name, image_dir)
    # This 生成所有的id包含的图片后，返回image_dir 这个变量，这个变量后续需要用来进行压缩下载
    return image_dir
     
 
 # This input_graph_info页面提交的form表单数据来到这里进行处理
@login_required
@permission_verify()       
def sendgraph_info(request):
    st = request.POST.get('starttime')
    et = request.POST.get('endtime')
    gids = request.POST.get('graphid')
    graphgroups = request.POST.get('graphgroup')
    # This 先判断生成报表的要素中的图片id是用户通过手动输入图片id的方式提供的，还是通过选择图片组id提供的
    if graphgroups:
        # This 加个split是将这个graphgroups字符串专程list列表，传给函数继续处理
        graphids = graphgroups.split(",")
    elif gids:
        graphids = gids.split(",")
    else:
        return HttpResponse('未手动填写监控图id或未选择监控图组！')

    # This 这里将st字符串转成时间类型，这样才能传给函数进行处理，否则无法处理报错
    starttime = datetime.datetime.strptime(st,"%Y-%m-%d %H:%M:%S")
    endtime = datetime.datetime.strptime(et,"%Y-%m-%d %H:%M:%S")
    
    # This 上述处理的一些参数，都传给函数get_time_graph进行处理，该函数返回了一个image_dir值，也就是生成的报表图片路径的值
    # This 这个变量后续需要用来进行压缩下载
    image_dir = get_time_graph(request, starttime, endtime, graphids)
    
    # workdir 是获取当前工作目录的父母路，也就是项目路径
    workdir = os.path.abspath('.')
    # This 报表模板定义
    example_report = workdir + '/zabbix/example_report/data_report.html'
    
    # This 定义年、月、Title，这些变量都是需要替换模板报表里面的相关信息的
    year = st.split('-')[0]
    month = st.split('-')[1]
    title = year + '年' + month + '月份服务器使用情况报表'
    
    # This 根据上面拿到的信息，使用sed命令进行操作系统层面的字符串替换
    sed_cmd = "/usr/bin/sed -i " + "'s/Title/" + title + "/g'" + " " + example_report + '&& ' + "/usr/bin/sed -i " + "'s/StartTime/" + st + "/g'" + " " + example_report + "&& " + "/usr/bin/sed -i " + "'s/EndTime/" + et + "/g'" + " " + example_report
    p_sed = Popen(sed_cmd, stdout=PIPE, stderr=PIPE, shell=True)
    p_sed.communicate()
    
    # This 定义报表模板默认文件，每一次生成报表后，替换了关键内容后，都需要还原这个文件到模板文件
    example_report_default = workdir + '/zabbix/example_report/data_report_default.html'
    report_dir = image_dir.split('png')[0]
    # This 第一个cp是将替换之后的模板为文件拷贝到监控图目录所在的同级目录下
    # This 第二个cp是将data_report_default.html替换data_report.html，这样保证下一个生成报表能替换关键字符成功
    report_cmd = 'cp -ar ' + example_report + ' ' +  report_dir + '&& ' + 'cp -ar ' + example_report_default + ' ' +  example_report
    p_report = Popen(report_cmd, stdout=PIPE, stderr=PIPE, shell=True)
    p_report.communicate()
    
    #cmd = "cd " + image_dir +" && ls -l"
    #p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    #data = p.communicate()
    results = {
        'image_dir':  image_dir,
        #'data': data,
        'starttime': starttime,
        'endtime': endtime,
     }
    # This 这里需要注意的是，到此为止，报表仍未生成，因为我们还有一些监控图信息是需要手动上传的，具体哪个程序处理可查看get_graph_info页面的form表单
    return render(request, 'zabbix/get_graph_info.html', results)
    

# This 输入报表生成所需要的要素信息
@login_required
@permission_verify()
def input_graph_info(request):
    monitor_group = MonitorGraph.objects.all()
    # This 获取监控图组，方便在生成报表的时候如果不选择手动输入，也可以选择监控图组，省时省力
    results = {
        'monitor_group': monitor_group,
     }
    return render(request, 'zabbix/input_graph_info.html', results)


# 监控图组列表
@login_required
@permission_verify()
def graph_group_list(request):
    all_graph_group = MonitorGraph.objects.all()
    results = {
        'all_graph_group':  all_graph_group,
    }
    return render(request, 'zabbix/graph_group_list.html', results)


# 监控图组的增加
@login_required
@permission_verify()
def graph_group_add(request):
    if request.method == "POST":
        # This 页面输入的监控图组名称
        groupname = request.POST.get('groupname')
        gids = request.POST.get('graphid')
        graphgroups = request.POST.getlist('graphgroup',[])
        # This 判断是通过手动输入id的方式还是通过选择图片id的方式来进行图片id的确定的
        if graphgroups:
            allid = ",".join(graphgroups)
        elif gids:
            allid = gids
        else:
            return HttpResponse('未手动填写监控图id或未选择监控图！')
        # This 创建一个监控图组记录，创建完记录之后返回监控图组列表页
        MonitorGraph.objects.create(groupname=groupname, graphids=allid)
        return HttpResponseRedirect(reverse('graph_group_list'))
        #form = GraphGroupForm(request.POST)
        #if form.is_valid():
        #    form.save()
        #    return HttpResponseRedirect(reverse('graph_group_list'))
        
    # This 如果用户是用get方式来请求这个页面，那就把监控图组输入框显示
    else:
        # This 在添加监控图组的时候，选有图片id选项框，这个选项框里面的内容并不是在数据库中的，需要从zabbix接口实时调取
        zapi=ZabbixAPI()
        #token=zapi.UserLogin()
        #print(token)
        hosts=zapi.MyHostGet()
        
        mydictlist = []
        
        for host in hosts:
            mydict = {}
            #print(host)
            hostid = host['hostid']
            hostname = host['host']
            graphinfo = host['graphs']
            #print(hostid,hostname,graphinfo)
            for graph in graphinfo:
                mydict.update({'hostname':hostname, 'hostid':hostid, graph['name']:graph['graphid']})
            mydictlist.append(mydict)
        #form = GraphGroupForm()

    results = {
        #'form': form,
        'mydictlist': mydictlist,
        'request': request,
    }

    return render(request, 'zabbix/graph_group_add.html', results)


# 监控图组的编辑
@login_required
@permission_verify()
def graph_group_edit(request, ids):
    graph_group = MonitorGraph.objects.get(id=ids)
    # This 直接使用form表单进行验证
    if request.method == "POST":
        form = GraphGroupForm(request.POST, instance=graph_group)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('graph_group_list'))
    # This 如果不是post请求，那就返回编辑页面，其中包括原来的数据也append上去
    else:
        form = GraphGroupForm(instance=graph_group)

    results = {
        'ids': ids,
        'form': form,
        'request': request,
    }
    # This 本来add页面使用编辑页面也行的，但是add页面新增了图片id选择选项，所以分开了两个页面
    return render(request, 'zabbix/graph_group_edit.html', results)


# 监控图组的删除
@login_required
@permission_verify()
def graph_group_del(request, ids):
    MonitorGraph.objects.filter(id=ids).delete()
    return HttpResponseRedirect(reverse('graph_group_list'))


# This 报表生成接近完成的时候，有些监控图像是没办法通过zabbix接口去调用的，所以在报表生成前先上传这些没办法通过zabbix接口生成的图片
# This 其中包括了生成报表后，压缩，并下载
@login_required
@permission_verify()
def graph_upload(request):
    if request.method == "POST":    # 请求方法为POST时，进行处理  
        myFiles =request.FILES.getlist("myfile", None)    # 获取上传的文件，如果没有文件，则默认为None
        image_dir = request.POST.get('image_dir')
        for myFile in myFiles:
            destination = open(os.path.join(image_dir,myFile.name),'wb+')    # 打开特定的文件进行二进制的写操作  
            for chunk in myFile.chunks():      # 分块写入文件  
                destination.write(chunk)  
            destination.close()
        
        # This 获取报告图片的父路径
        report_dir = image_dir.split('png')[0]
        # This 获取路径中包含的报表统计时间的信息
        data_info = image_dir.split('report/')[1].split('/png')[0]
        # This 组合命令，在系统上执行
        zip_cmd = 'cd ' + report_dir + ' ' + '&& ' + 'zip -r ' + 'Report_' + data_info + '.zip ' + './*'
        zip_report = Popen(zip_cmd, stdout=PIPE, stderr=PIPE, shell=True)
        zip_report.communicate()
        
        # This 获取压缩包的名字
        z_name = report_dir + 'Report_' + data_info + '.zip'
        # This 以二进制方式打开压缩包，准备进行下载
        z_file = open(z_name, 'rb')
        data = z_file.read()
        z_file.close()
        response = HttpResponse(data, content_type='application/zip')
        # This z_name.split('/')[-1] 是取最直接的压缩包名，包前面的var/tmp/xxx的省略掉
        response['Content-Disposition'] = 'attachment;filename=' + parse.quote(z_name.split('/')[-1])
        # This 这个return就是让压缩包在浏览器开始下载
        return response
        

