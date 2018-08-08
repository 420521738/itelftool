#!/usr/bin/env python
#coding:utf-8

from plugins import plugin_api
import json,platform,sys


class InfoCollection(object):
    def __init__(self):
        pass

    # 判断操作系统类型
    def get_platform(self):
        os_platform = platform.system()
        return os_platform

    # 数据收集函数
    def collect(self):
        os_platform = self.get_platform()
        try:
            # 先用反射查询是否有对应操作系统的函数，如果有，就进行反射获取函数，并且执行函数
            func = getattr(self,os_platform)
            # func加入是linux，则info_data就是linux（）函数执行返回的结果
            info_data = func()
            formatted_data = self.build_report_data(info_data)
            # 将结果返回给report_asset里的obj
            return formatted_data
        # 如果有异常，就提示该操作系统不支持信息收集
        except AttributeError as e:
            sys.exit("Error:MadKing doens't support os [%s]! " % os_platform)

    # 如果操作系统是linux
    def Linux(self):
        # 则调用plugin_api下的LinuxSysInfo方法进行收集
        sys_info = plugin_api.LinuxSysInfo()

        return sys_info
    
    # 如果操作系统是windows
    def Windows(self):
        # 则调用plugin_api下的WindowsSysInfo方法进行收集
        sys_info = plugin_api.WindowsSysInfo()
        return sys_info

    def build_report_data(self,data):
        # 目前该函数并未有较大的作用，后续再看下是否需要添加什么功能
        return data
