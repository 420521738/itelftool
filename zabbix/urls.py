#!/usr/bin/env python
#coding:utf-8

from django.conf.urls import url

from . import get_hostinfo
from . import getgraphs


urlpatterns = [
    url(r'^hostinfo/list/$', get_hostinfo.main, name='hostinfo_list'),
    url(r'^input/graph_info/$', getgraphs.input_graph_info, name='input_graph_info'),
    url(r'^send/graph_info/$', getgraphs.sendgraph_info, name='sendgraph_info'),
    
    url(r'^graphgroup/list/$', getgraphs.graph_group_list, name='graph_group_list'),
    url(r'^graphgroup/add/$', getgraphs.graph_group_add, name='graph_group_add'),
    url(r'^graphgroup/edit/(?P<ids>\d+)/$', getgraphs.graph_group_edit, name='graph_group_edit'),
    url(r'^graphgroup/delete/(?P<ids>\d+)/$', getgraphs.graph_group_del, name='graph_group_del'),
    
    url(r'^graph/upload/$', getgraphs.graph_upload, name='graph_upload'),
]
