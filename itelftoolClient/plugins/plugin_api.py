#!/usr/bin/env python
#coding:utf-8


from plugins.linux import sysinfo
from plugins.windows import sysinfo as win_sysinfo



def LinuxSysInfo():
    return  sysinfo.collect()


def WindowsSysInfo():
    return win_sysinfo.collect()
