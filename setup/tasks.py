#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
from celery import shared_task
from subprocess import Popen, PIPE
from assets.models import Asset, NIC


# 如果发现注册不了任务，那么则有可能是使用import导入了错误的模块，比如在此系统无法使用的模块
from config.views import get_dir
scripts_dir = get_dir("s_path")

@shared_task
def command(host, name):
    ret = []
    h = Asset.objects.get(name=host)
    nicinfo = NIC.objects.get(asset_id = h.id)
    ip = nicinfo.ipaddress
    cmd = name
    cmd = "ssh chenqiufei@"+ip+" "+'"{}"'.format(cmd)
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    data = p.communicate()
    ret.append(data)

    return ret


@shared_task
def script(host, name):
    ret = []
    h = Asset.objects.get(name=host)
    s = name
    nicinfo = NIC.objects.get(asset_id = h.id)
    ip = nicinfo.ipaddress
    try:
        # windows开发环境下需要进行的路径字符串替换，如果是在linux下根本不需要这么写，直接调用sh模块调用命令就行了
        temp_scripts_dir = scripts_dir.replace('\\\\','/')
        scriptsdir = temp_scripts_dir.replace(':','')
        scpcmd = "scp "+"/cygdrive/"+scriptsdir+s+" "+"chenqiufei@{}:/tmp/".format(ip)+s
        scp_p = Popen(scpcmd, stdout=PIPE, stderr=PIPE, shell=True)
        data = scp_p.communicate()
        ret.append(data)
    except:
        pass
    
    cmd = "ssh chenqiufei@"+ip+" "+'"sh /tmp/{} {}"'.format(s)
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    data = p.communicate()
    ret.append(data)
    return ret

