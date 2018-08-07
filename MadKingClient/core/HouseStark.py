#!/usr/bin/env python
#coding:utf-8

from core import info_collection
from conf import settings
import sys,os,json,datetime
from urllib.parse import urlencode
import urllib.parse
import urllib.request
from core import api_token


class ArgvHandler(object):
    # 执行构造函数
    def __init__(self,argv_list):
        # self.argvs是一个字典，在windows下是['C:\\Users\\Administrator\\eclipse-workspace\\MadKing\\MadKingClient\\bin\\NedStark.py', 'report_asset']
        self.argvs = argv_list
        # 执行函数parse_argv
        self.parse_argv()

    # 判断客户端执行的参数个数，如果大于1，就判断第二个参数是否有此函数，如果有就执行该此函数，如果没有，就打印帮助信息
    def parse_argv(self):
        if len(self.argvs) >1:
            # 反射，判断是否有例如report_asset方法，传进来的report_asset是字符串，所以需要用反射来判断
            if hasattr(self,self.argvs[1]):
                # 如果有report_asset方法，则将report_asset方法赋予给func，再执行func，就相当于执行了report_asset函数
                func = getattr(self,self.argvs[1])
                func()
            else:
                self.help_msg()
        else:
            self.help_msg()
            
    def help_msg(self):
        msg = '''
        collect_data       收集硬件信息
        run_forever
        load_asset_id
        report_asset       收集硬件信息并汇报 
        '''
        print(msg)

    def collect_data(self):
        """收集硬件信息"""
        obj = info_collection.InfoCollection()
        asset_data = obj.collect()
        print(asset_data)

    def run_forever(self):
        pass

    # 客户端使用md5算法，将用户tokenid以及用户名、时间戳产生一个md5值，发送给服务端进行校验
    def __attach_token(self,url_str):
        '''generate md5 by token_id and username,and attach it on the url request'''
        # 从客户端的配置文件中获取用户名
        user = settings.Params['auth']['user']
        # 从客户端的配置文件中获取token
        token_id = settings.Params['auth']['token']
        # 把user以及token_id作为参数传给core下的get_token函数进行处理，并由该函数返回两个变量
        # 返回两个数值，第一个数值是经过md5之后的截取数值，一个是加密时使用的时间戳
        md5_token,timestamp = api_token.get_token(user,token_id)
        # 拼凑url，类似于/asset/report/?user=420521738@qq.com&timestamp=1533541168&token=b80e7d1
        url_arg_str = "user=%s&timestamp=%s&token=%s" %(user,timestamp,md5_token)
        # url_str类似于：http://192.168.7.199:8002/asset/report/
        if "?" in url_str:#already has arg
            new_url = url_str + "&" + url_arg_str
        else:
            new_url = url_str + "?" + url_arg_str
        # new_url 类似于：http://192.168.7.199:8002/asset/report/?user=420521738@qq.com&timestamp=1533541322&token=09e02f7
        return  new_url
        #print(url_arg_str)

    # 三个参数分别是提交到的url，数据，以及提交的方法
    def __submit_data(self,action_type,data,method):
        # 先判断客户端提交到的url是否在配置文件的urls里面，如果在，才执行下面的操作
        if action_type in settings.Params['urls']:
            # 判断是否有端口，如果有端口
            if type(settings.Params['port']) is int:
                url = "http://%s:%s%s" %(settings.Params['server'],settings.Params['port'],settings.Params['urls'][action_type])
            # 如果没有端口
            else:
                url = "http://%s%s" %(settings.Params['server'],settings.Params['urls'][action_type])
            #print(url)
            # 类似于：http://192.168.7.199:8002/asset/report/?user=420521738@qq.com&timestamp=1533541322&token=09e02f7
            url =  self.__attach_token(url)
            print('Connecting [%s], it may take a minute' % url)
            if method == "get":
                args = ""
                for k,v in data.items():
                    args += "&%s=%s" %(k,v)
                args = args[1:]
                url_with_args = "%s?%s" %(url,args)
                try:
                    #req = urllib2.Request(url_with_args)
                    #req = urllib.request(url_with_args)
                    req = urllib.request.Request(url=url_with_args)
                    #req_data = urllib2.urlopen(req,timeout=settings.Params['request_timeout'])
                    req_data = urllib.request.urlopen(req,timeout=settings.Params['request_timeout'])
                    callback = req_data.read()
                    print("-->server response:",callback)
                    return callback
                #except urllib2.URLError as e:
                except urllib.request.URLError as e:
                    sys.exit("\033[31;1m%s\033[0m"%e)
            elif method == "post":
                try:
                    # 秋飞修改
                    #data_encode = urllib.urlencode(data)
                    # urllib.parse.urlencode(data)的作用就是将data数据做成url，例如query = {'name': 'walker','age': 99,}，执行了之后就变成'name=walker&age=99'
                    data_encode = urllib.parse.urlencode(data).encode(encoding='UTF8')
                    #req = urllib2.Request(url=url,data=data_encode)
                    # 利用urlopen()方法可以实现最基本请求的发起
                    req = urllib.request.Request(url=url,data=data_encode)
                    #print(req)
                    #res_data = urllib2.urlopen(req,timeout=settings.Params['request_timeout'])
                    # 用Request类构建了一个完整的请求，增加了headers等一些信息
                    res_data = urllib.request.urlopen(req,timeout=settings.Params['request_timeout'])
                    #print('00000000',res_data)
                    #print('11111111',type(res_data))
                    callback = res_data.read().decode("utf8")
                    #print('22222222',callback)
                    #print('33333333',type(callback))
                    callback = json.loads(callback)
                    print("\033[31;1m[%s]:[%s]\033[0m response:\n%s" %(method,url,callback))
                    return callback
                except Exception as e:
                    sys.exit("\033[31;1m%s\033[0m"%e)
        else:
            raise KeyError



    #def __get_asset_id_by_sn(self,sn):
    #    return  self.__submit_data("get_asset_id_by_sn",{"sn":sn},"get")
    # 查找是否有asset_id_file，如果有就返回asset_id，没有的话，就返回False
    def load_asset_id(self,sn=None):
        asset_id_file = settings.Params['asset_id']
        has_asset_id = False
        if os.path.isfile(asset_id_file):
            asset_id = open(asset_id_file).read().strip()
            if asset_id.isdigit():
                return  asset_id
            else:
                has_asset_id =  False
        else:
            has_asset_id =  False

    def __update_asset_id(self,new_asset_id):
        asset_id_file = settings.Params['asset_id']
        f = open(asset_id_file,"wb")
        f.write(str(new_asset_id))
        f.close()

    # 汇报资产信息的函数
    def report_asset(self):
        # 实例化obj
        obj = info_collection.InfoCollection()
        # 客户端执行obj实例下的collect函数进行数据收集
        asset_data = obj.collect()
        # 查看客户端本地的asset_id文件是否有id写入，这里的sn其实没什么用暂时
        asset_id = self.load_asset_id(asset_data["sn"])
        # 先确定本地客户端是否有asset_id号
        if asset_id:
            # 如果本地有asset_id号，那就往asset_data里添加一条key为asset_id，value为asset_id的数据，并且指定执行提交数据的url
            asset_data["asset_id"] = asset_id
            post_url = "asset_report"
        else:#first time report to server
            '''report to another url,this will put the asset into approval waiting zone, when the asset is approved ,this request returns
            asset's ID'''
            # 如果本地没有asset_id号，那就往asset_data里添加一条key为asset_id，value为None的数据，并且指定执行提交数据的url
            asset_data["asset_id"] = None
            post_url = "asset_report_with_no_id"

        data = {"asset_data": json.dumps(asset_data)}
        # 执行__submit_data私有函数方法，三个参数分别是提交到的url，数据，以及提交的方法
        response = self.__submit_data(post_url,data,method="post")
        if "asset_id" in response:
            self.__update_asset_id(response["asset_id"])

        self.log_record(response)

    def log_record(self,log,action_type=None):
        # 如果文件打开模式带 b，那写入文件内容时，str (参数)要用 encode 方法转为 bytes 形式，否则报错：TypeError: a bytes-like object is required, not 'str'。
        f = open(settings.Params["log_file"],"ab")
        if log is str:
            pass
        #print(type(log))
        if type(log) is dict:

            if "info" in log:
                for msg in log["info"]:
                    log_format = "%s\tINFO\t%s\n" %(datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S"),msg)
                    #print msg
                    f.write(log_format.encode())
            if "error" in log:
                for msg in log["error"]:
                    log_format = "%s\tERROR\t%s\n" %(datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S"),msg)
                    print(type(log_format))
                    f.write(log_format.encode())
            if "warning" in log:
                for msg in log["warning"]:
                    log_format = "%s\tWARNING\t%s\n" %(datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S"),msg)
                    f.write(log_format.encode())

        f.close()
