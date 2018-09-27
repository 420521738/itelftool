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
    job_workspace = "/var/opt/itelftool/fastexcute/workspace/{0}/".format(name)
    log_path = job_workspace + 'logs/'
    log_name = 'deploy' + ".log"
    with open(log_path + log_name, 'w+') as f:
        f.writelines("<h4 style='color:#0000FF;font-weight:normal;'>正在上线 {0}的项目代码</h4>".format(name))
    
    # This 更新进度
    p1.bar_data = 40
    p1.save()
    sleep(1)
    
    cmd_html = p1.shell
    username = p1.server.username
    port = p1.server.port
    
    # This 更新进度
    p1.bar_data = 60
    p1.save()
    sleep(1)
    
    # This 获取每一行的命令，如果有多行的话
    command_list = cmd_html.split('\r')
    for cmd in command_list:
        complete_cmd = ('ssh -p ' +'{0} ' + '{1}' + '@' + '{2} ' + '"{3}"').format(port, username, serverip, cmd)
        with open(log_path + log_name, 'a+') as f:
            f.writelines("<h5 style='color:#0000FF;'>正在服务器： {0} 上执行命令： {1} ，命令执行输出如下：</h5>".format(serverip, cmd))
        #data = cmd_exec(complete_cmd)
        p = Popen(complete_cmd, stdout=PIPE, stderr=PIPE, shell=True)
        data = p.communicate()
        
        # This p.communicate()之后，p都会有一个returncode，这个returncode就和我们平时在linux下执行完命令后，echo $?一样，执行未出错这个值等于0
        step_status = p.returncode
        
        with open(log_path + log_name, 'ab+') as f:
            f.writelines(data)
        
        # This 判断执行返回码的值是不是0，如果不是0，那就是这一步执行出错了，需要终止下面的步骤
        # This 需要注意的是，如果是一个脚本的执行，需要在脚本里面也进行判断，毕竟程序不能参与脚本里面的执行判断
        if step_status == 0:
            pass
        else:
            with open(log_path + log_name, 'a+') as f:
                f.writelines("<h4 style='color:red;font-weight:normal;'>{0} 项目更新失败，请查看以上日志错误信息！ </h4>".format(p1.name))
            # This 如果执行出错了，重置status为False，并且将进度条的值设置为99，也就是执行失败的意思
            p1.bar_data = 99
            p1.status = False
            p1.save()
            # This 读取日志，并将日志的全部信息赋值到all_log_info变量中，并将这条记录写入数据库
            with open(log_path + log_name, 'r') as f:
                    all_log_info = f.read()
            FastexcudeRecord.objects.create(excudename=name, excudeuser=excudeuser, excudeserver=serverip, excude_time=excudetime, excudestatus=False, excudelog=all_log_info)
            return data
        
    p1.bar_data = 110
    p1.save()
    sleep(1)
    
    with open(log_path + log_name, 'a+') as f:
        f.writelines("<h4 style='color:green;font-weight:normal;'>{0} 项目已经完成上线！ </h4>".format(p1.name))

    # This 如果执行过程都没有出错，那就设定进度条为满值130，status也设置为False，意思是执行完了，并且执行成功
    p1.bar_data = 130
    p1.status = False
    p1.save()
    with open(log_path + log_name, 'r') as f:
        all_log_info = f.read()
    FastexcudeRecord.objects.create(excudename=name, excudeuser=excudeuser, excudeserver=serverip, excude_time=excudetime, excudestatus=True, excudelog=all_log_info)
    return data
