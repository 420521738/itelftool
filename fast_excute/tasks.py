#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
from celery import shared_task
from subprocess import Popen, PIPE
from fast_excute.models import Fastexcude
from fast_excute.models import FastexcudeRecord
import os
from time import sleep
import sh
from aiohttp.client import request


def deploy(name, serverip, project_id, excudetime, excudeuser):
    cmd = ""
    p1 = Fastexcude.objects.get(id=project_id)
    
    # This 执行日志信息
    
    job_workspace = "/var/opt/itelftool/fastexcute/workspace/{0}/".format(name)
    log_path = job_workspace + 'logs/'
    log_name = 'deploy' + ".log"
    with open(log_path + log_name, 'w+') as f:
        f.writelines("<h4 style='color:#0000FF;font-weight:normal;'>正在上线 {0}的项目代码</h4>".format(name))

    p1.bar_data = 40
    p1.save()
    sleep(1)
    
    cmd_html = p1.shell
    username = p1.server.username
    port = p1.server.port
    
    p1.bar_data = 60
    p1.save()
    sleep(1)
    
    command_list = cmd_html.split('\r')
    for cmd in command_list:
        complete_cmd = ('ssh -p ' +'{0} ' + '{1}' + '@' + '{2} ' + '"{3}"').format(port, username, serverip, cmd)
        with open(log_path + log_name, 'a+') as f:
            f.writelines("<h5 style='color:#0000FF;'>正在服务器： {0} 上执行命令： {1} ，命令执行输出如下：</h5>".format(serverip, cmd))
        #data = cmd_exec(complete_cmd)
        p = Popen(complete_cmd, stdout=PIPE, stderr=PIPE, shell=True)
        data = p.communicate()
        
        step_status = p.returncode
        
        with open(log_path + log_name, 'ab+') as f:
            f.writelines(data)
        
        if step_status == 0:
            pass
        else:
            with open(log_path + log_name, 'a+') as f:
                f.writelines("<h4 style='color:red;font-weight:normal;'>{0} 项目更新失败，请查看以上日志错误信息！ </h4>".format(p1.name))
            p1.bar_data = 99
            p1.status = False
            p1.save()
            FastexcudeRecord.objects.create(excudename=name, excudeuser=excudeuser, excudeserver=serverip, excude_time=excudetime, excudestatus=False)
            return data
        
    p1.bar_data = 110
    p1.save()
    sleep(1)
    
    with open(log_path + log_name, 'a+') as f:
        f.writelines("<h4 style='color:green;font-weight:normal;'>{0} 项目已经完成上线！ </h4>".format(p1.name))

    p1.bar_data = 130
    p1.status = False
    p1.save()
    FastexcudeRecord.objects.create(excudename=name, excudeuser=excudeuser, excudeserver=serverip, excude_time=excudetime, excudestatus=True)
    return data


def cmd_exec(cmd):
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    data = p.communicate()
    return data
