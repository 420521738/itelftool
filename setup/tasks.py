#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
from celery import shared_task
from subprocess import Popen, PIPE
from assets.models import Asset, NIC
import sh
import json

# 如果发现注册不了任务，那么则有可能是使用import导入了错误的模块，比如在此系统无法使用的模块
from config.views import get_dir
scripts_dir = get_dir("s_path")


@shared_task
def command(host, name):
    h = Asset.objects.get(name=host)
    nicinfo = NIC.objects.get(asset_id = h.id)
    ip = nicinfo.ipaddress
    cmd = sh.ssh("chenqiufei@"+ip, " "+name)
    data = str(cmd)
    return data


@shared_task
def script(host, name):
    h = Asset.objects.get(name=host)
    nicinfo = NIC.objects.get(asset_id = h.id)
    ip = nicinfo.ipaddress
    sh.scp(scripts_dir+name, "chenqiufei@"+ip+":/tmp/"+name)
    cmd = "ssh chenqiufei@"+ip+" "+'"sh /tmp/{}"'.format(name)
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    data = p.communicate()
    return data

