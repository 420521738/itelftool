#!/usr/bin/env python
# -*- coding: utf-8 -*-

from accounts.permission import permission_verify
from django.contrib.auth.decorators import login_required
import json
import urllib.request, urllib.error, urllib.parse
from django.shortcuts import render



class ZabbixAPI:
    def __init__(self):
        self.__url = 'http://121.201.48.67:16111/api_jsonrpc.php'
        self.__user = 'Admin'
        self.__password = 'zabbix@gz711'
        self.__header = {"Content-Type": "application/json-rpc"}
        self.__token_id = self.UserLogin()
    #登陆获取token
    def UserLogin(self):
        data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": {
                "user": self.__user,
                "password": self.__password
            },
            "id": 0,
        }
        return self.PostRequest(data)
    #推送请求
    def PostRequest(self, data):
        request = urllib.request.Request(self.__url,json.dumps(data).encode('utf-8'),self.__header)
        result = urllib.request.urlopen(request)
        response = json.loads(result.read().decode('utf-8'))
        try:
            # print response['result']
            return response['result']
        except KeyError:
            raise KeyError
 
 
 
 
    def MyHostGet(self,hostid=None,hostip=None):
        data = {
                "jsonrpc": "2.0",
                "method": "host.get",
                "params": {
                    "output": ["host"],
                    "selectGraphs":["graphid","name"],
                },
                "id": 2,
                "auth": self.__token_id,
            }
        if hostid:
            data["params"]={
                "output": "extend",
                "hostids": hostid,
                "sortfield": "name"
            }
        return  self.PostRequest(data)       
    


# 获取监控里包含的主机，以及各个主机id，主机对应的图的id，用于创建监控图组  
@login_required
@permission_verify()
def main(request):
    # This 实例化一个类
    zapi=ZabbixAPI()
    #token=zapi.UserLogin()
    #print(token)
    # This 调用类的MyHostGet方法
    hosts=zapi.MyHostGet()
    
    mydictlist = []
    
    # hosts返回的是host的监控名，主机的id，监控图id以及监控图名称
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
    
    
    results = {
        'mydictlist': mydictlist,
        'request': request,
    }
        
    return render(request, 'zabbix/hostinfo_list.html', results)