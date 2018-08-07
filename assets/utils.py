#!/usr/bin/env python
#coding:utf-8

import time,hashlib,json
from assets import models
from django.shortcuts import render,HttpResponse
from itelftool import settings

from django.core.exceptions import ObjectDoesNotExist
def json_date_handler(obj):
    if hasattr(obj, 'isoformat'):
        return obj.strftime("%Y-%m-%d")


def json_datetime_handler(obj):
    if hasattr(obj, 'isoformat'):
        return obj.strftime("%Y-%m-%d %H:%M:%S")


# 传进来的三个参数分别是用户名、时间戳，以及数据库中查到的该用户的token值
def gen_token(username,timestamp,token):
    # 使用用户名、时间戳，以及数据库中查到的该用户的token值创建一个字符串
    token_format = "%s\n%s\n%s" %(username,timestamp,token)
    #print('--->token format:[%s]'% token_format)
    # 使用的加密方法，以及截取方法和客户端的一模一样，客户端加密方法在MadKingClient/core/api_token里
    obj = hashlib.md5()
    obj.update(token_format.encode())
    return obj.hexdigest()[10:17]


# 类似请求进行/asset/report/?user=420521738@qq.com&timestamp=1532676444&token=ed6926d
def token_required(func):
    def wrapper(*args,**kwargs):
        # 先创建一个空的response空字典，字典的key是errors
        response = {"errors":[]}
        # get_args 类似于<QueryDict: {'timestamp': ['1533542012'], 'user': ['420521738@qq.com'], 'token': ['752c3ec']}>
        get_args = args[0].GET
        username = get_args.get("user")
        token_md5_from_client = get_args.get("token")
        timestamp = get_args.get("timestamp")
        # 如果url中没有带用户名、时间戳、以及md5值中的任意一项的话就往response字典里写错误信息
        if not username or not timestamp or not token_md5_from_client:
            response['errors'].append({"auth_failed":"This api requires token authentication!"})
            # 将错误信息返回到页面上显示
            return HttpResponse(json.dumps(response))
        try:
            # 从数据库中获取email等于username字段的数据，user_obj.token就是用户在数据库中的token字段，也是客户端在settings中设置的token值
            user_obj = models.UserProfile.objects.get(email=username)
            # 将用户名、时间戳，以及数据库中查到的该用户的token值传给gen_token函数
            # gen_token返回的是经过md5之后的截取数值obj.hexdigest()[10:17]
            token_md5_from_server = gen_token(username,timestamp,user_obj.token)
            # 对比客户端传过来的md5截取值和服务器端算出来的md5值是否一致，如果不一致
            if token_md5_from_client != token_md5_from_server:
                response['errors'].append({"auth_failed":"Invalid username or token_id!"})
            # 如果一致
            else:
                # 首先计算当前时间与客户端传过来的时间戳的间隔是否在120s的有效时间以内，如果超过了120s
                if abs(time.time() - int(timestamp)) > settings.TOKEN_TIMEOUT:# default timeout 120
                    # 则将错误信息写入response字典里
                    response['errors'].append({"auth_failed":"The token is expired!"})
                else:
                    # 如果验证通过，什么也不需要操作
                    pass #print "\033[31;1mPass authentication\033[0m"

                #print("\033[41;1m;%s ---client:%s\033[0m" %(time.time(),timestamp), time.time() - int(timestamp))
        except ObjectDoesNotExist as e:
            response['errors'].append({"auth_failed":"Invalid username or token_id"})
        # 上面代码执行捕获的异常，如果response中的errors里有数据，则在页面上将错误异常显示出来
        if response['errors']:
            return HttpResponse(json.dumps(response))
        else:
            return  func(*args,**kwargs)
    # 如果没有异常，token验证通过了，装饰器执行完成
    return wrapper