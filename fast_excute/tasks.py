#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
from celery import shared_task
from subprocess import Popen, PIPE
from fast_excute.models import Fastexcude
import os
from time import sleep
import sh


def deploy(name, serverip, project_id):
    cmd = ""
    p1 = Fastexcude.objects.get(id=project_id)
    job_workspace = "/var/opt/itelftool/fastexcute/workspace/{0}/".format(name)
    log_path = job_workspace + 'logs/'
    log_name = 'deploy' + ".log"
    with open(log_path + log_name, 'w+') as f:
        f.writelines("<h4 style='color:#0000FF;font-weight:normal;'>正在上线 {0}的项目代码</h4>".format(name))

    p1.bar_data = 30
    p1.save()
    sleep(1)
    
    cmd = p1.shell
    username = p1.server.username
    port = p1.server.port
    complete_cmd = ('ssh -p ' +'{0} ' + '{1}' + '@' + '{2} ' + '"{3}"').format(port, username, serverip, cmd)
    
    with open(log_path + log_name, 'a+') as f:
        f.writelines("<h5 style='color:#0000FF;'>正在服务器： {0} 上执行命令： {1} </h5>".format(serverip, cmd))
    
    data = cmd_exec(complete_cmd)
    p1.bar_data = 50
    p1.save()
    
    with open(log_path + log_name, 'a+') as f:
        f.writelines("<h5 style='color:#0000FF;'>命令执行过程日志输出如下：</h5>")
    
    with open(log_path + log_name, 'ab+') as f:
        f.writelines(data)

    p1.bar_data = 130
    p1.status = False
    p1.save()
    with open(log_path + log_name, 'a+') as f:
        f.writelines("<h4 style='color:green;font-weight:normal;'>{0} 项目已经完成上线！ </h4>".format(p1.name))
    return data


def cmd_exec(cmd):
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
    data = p.communicate()
    return data
