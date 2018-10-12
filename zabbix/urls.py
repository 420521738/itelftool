#!/usr/bin/env python
#coding:utf-8

from django.conf.urls import url

from zabbix import get_hostinfo
from zabbix import getgraphs


urlpatterns = [
    # This 获取监控里包含的主机，以及各个主机id，主机对应的图的id，用于创建监控图组
    url(r'^hostinfo/list/$', get_hostinfo.main, name='hostinfo_list'),
    
    # This 输入报表生成所需要的要素信息
    url(r'^input/graph_info/$', getgraphs.input_graph_info, name='input_graph_info'),
    
    # This input_graph_info页面提交的form表单数据来到这里进行处理
    url(r'^send/graph_info/$', getgraphs.sendgraph_info, name='sendgraph_info'),
    
    # This 监控图组的增删该查
    url(r'^graphgroup/list/$', getgraphs.graph_group_list, name='graph_group_list'),
    url(r'^graphgroup/add/$', getgraphs.graph_group_add, name='graph_group_add'),
    url(r'^graphgroup/edit/(?P<ids>\d+)/$', getgraphs.graph_group_edit, name='graph_group_edit'),
    url(r'^graphgroup/delete/(?P<ids>\d+)/$', getgraphs.graph_group_del, name='graph_group_del'),
    
    # This 报表生成接近完成的时候，有些监控图像是没办法通过zabbix接口去调用的，所以在报表生成前先上传这些没办法通过zabbix接口生成的图片
    # This 其中包括了生成报表后，压缩，并下载
    url(r'^graph/upload/$', getgraphs.graph_upload, name='graph_upload'),
]
