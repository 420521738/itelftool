#!/usr/bin/env python
#coding:utf-8

import hashlib,time


# 从HouseStark的函数__attach_token传过来两个参数，一个是user，一个是tokenid
def get_token(username,token_id):
    # 获取当前时间戳，并进行整形化
    timestamp = int(time.time())
    # 基于tokenid以及用户名、时间戳产生一个md5值创建一个字符串
    md5_format_str = "%s\n%s\n%s" %(username,timestamp,token_id)
    # 秋飞修改
    #obj = hashlib.md5()
    #obj.update(md5_format_str)
    # 实例化obj，使用hashlib的md5方法
    obj = hashlib.md5()
    # 将md5_format_str字符串进行md5加密
    obj.update(md5_format_str.encode())
    #print(type(md5_format_str))
    # 秋飞修改
    print("token format:[%s]" % md5_format_str)
    print("token :[%s]" % obj.hexdigest())
    #print("%s" % md5_format_str)
    #print("%s" % obj.hexdigest())
    # obj.hexdigest() 作为十六进制数据字符串值，截取其中的第10位到第16位。返回两个数值，第一个数值是经过md5之后的截取数值，一个是加密时使用的时间戳
    return obj.hexdigest()[10:17], timestamp


if __name__ =='__main__':
    print (get_token('alex','test'))