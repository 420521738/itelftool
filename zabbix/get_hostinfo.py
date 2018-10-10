# -*- coding: utf-8 -*-
import json
import urllib.request, urllib.error, urllib.parse
from django.shortcuts import render

class ZabbixAPI:
    def __init__(self):
        self.__url = 'http://21.20.48.67:16888/api_jsonrpc.php'
        self.__user = 'Admin'
        self.__password = 'zabbix'
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
        

def main(request):
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
        
        #print(mydict)
    #print(mydictlist)
    
    
    results = {
        'mydictlist': mydictlist,
        'request': request,
    }
        
    return render(request, 'zabbix/hostinfo_list.html', results)