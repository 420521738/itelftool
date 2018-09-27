#! /usr/bin/env python
# -*- coding: utf-8 -*-
from assets.models import Asset, HostGroup, NIC
from django.shortcuts import render
from subprocess import Popen, PIPE
import sh
from config.views import get_dir
from django.contrib.auth.decorators import login_required
from lib.log import log
from lib.setup import get_scripts
import logging
from accounts.permission import permission_verify
from setup.models import TaskRecord
import datetime

scripts_dir = get_dir("s_path")
level = get_dir("log_level")
log_path = get_dir("log_path")
log("setup.log", level, log_path)


@login_required()
@permission_verify()
def index(request):
    all_host = Asset.objects.all()
    all_group = HostGroup.objects.all()
    all_scripts = get_scripts(scripts_dir)
    return render(request, 'setup/shell.html', locals())


@login_required()
@permission_verify()
def exec_scripts(request):
    # This 总体记录功能
    tasktype = '命令执行'
    taskuser = request.user.name
    tasktime = datetime.datetime.now()
    
    ret = []
    if request.method == 'POST':
        server = request.POST.getlist('mserver', [])
        group = request.POST.getlist('mgroup', [])
        scripts = request.POST.getlist('mscripts', [])
        args = request.POST.getlist('margs')
        command = request.POST.get('mcommand')

        if server:
            if scripts:
                for name in server:
                    host = Asset.objects.get(name=name)
                    nicinfo = NIC.objects.get(asset_id = host.id)
                    ip = nicinfo.ipaddress
                    ret.append(host.name)
                    logging.info("==========Script Start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("Host:"+host.name)
                    for s in scripts:
                        try:
                            sh.scp(scripts_dir+s, "chenqiufei@{}:/tmp/".format(ip)+s)
                        except:
                            pass
                        cmd = "ssh chenqiufei@"+ip+" "+'"sh /tmp/{} {}"'.format(s, args)
                        p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                        data = p.communicate()                   
                            
                        ret.append(data)
                        logging.info("Scripts:"+s)
                        for d in data:
                            logging.info(d)
                    logging.info("==========Script End============")
                    
                # This 局部记录功能
                taskinfo = '在服务器：{}  上执行脚本 ：{}'.format(server, scripts)
                
            else:
                for name in server:
                    host = Asset.objects.get(name=name)
                    nicinfo = NIC.objects.get(asset_id = host.id)
                    ip = nicinfo.ipaddress
                    ret.append(host.name)
                    logging.info("==========Shell Start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("Host:"+host.name)
                    command_list = command.split('\n')
                    for cmd in command_list:
                        cmd = "ssh chenqiufei@"+ip+" "+'"{}"'.format(cmd)
                        p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                        data = p.communicate()
                        ret.append(data)
                        logging.info("command:"+cmd)
                        for d in data:
                            logging.info(d)
                    logging.info("==========Shell End============")
                    
                # This 局部记录功能
                taskinfo = '在服务器：{}  上执行命令： {}'.format(server, command)
                
        if group:
            if scripts:
                for g in group:
                    logging.info("==========Script Start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("Group:"+g)
                    get_group = HostGroup.objects.get(name=g)
                    hosts = get_group.serverList.all()
                    serverlist = []
                    #f表结构适配，从groud里面获取到assetid，serverlist是整理后的资产列表
                    for server in hosts:
                        obj = Asset.objects.get(id=server.id)
                        serverlist.append(server)
                    ret.append(g)
                    
                    for asset in serverlist:
                        nicinfo = NIC.objects.get(asset_id = asset.id)
                        ip = nicinfo.ipaddress
                        ret.append(asset.name)
                        for s in scripts:
                            try:
                                sh.scp(scripts_dir+s, "chenqiufei@{}:/tmp/".format(ip)+s)
                            except:
                                pass
                            cmd = "ssh chenqiufei@"+ip+" "+'"sh /tmp/{} {}"'.format(s, args)
                            p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                            data = p.communicate()
                            ret.append(data)
                            logging.info("command:"+cmd)
                            for d in data:
                                logging.info(d)
                    logging.info("==========Script End============")
                    
                # This 局部记录功能
                taskinfo = '在服务器组：{}  上执行脚本 ：{}'.format(group, scripts)
                    
            else:
                command_list = []
                command_list = command.split('\n')
                for g in group:
                    logging.info("==========Shell Start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("Group:"+g)
                    get_group = HostGroup.objects.get(name=g)
                    hosts = get_group.serverList.all()
                    serverlist = []
                    for server in hosts:
                        obj = Asset.objects.get(id=server.id)
                        serverlist.append(server)
                    ret.append(g)
                    
                    for asset in serverlist:
                        nicinfo = NIC.objects.get(asset_id = asset.id)
                        ip = nicinfo.ipaddress
                        ret.append(asset.name)
                        for cmd in command_list:
                            cmd = "ssh chenqiufei@"+ip+" "+'"{}"'.format(cmd)
                            p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                            data = p.communicate()
                            ret.append(data)
                            logging.info("command:"+cmd)
                            for d in data:
                                logging.info(d)
                    logging.info("==========Shell End============")
                    
                # This 局部记录功能
                taskinfo = '在服务器组：{}  上执行命令： {}'.format(group, command)
                
        # This 总体记录功能
        status = p.returncode
        if status == 0:
            taskstatus = True
        else:
            taskstatus = False
        TaskRecord.objects.create(tasktype=tasktype, taskuser=taskuser, tasktime=tasktime, taskstatus=taskstatus, taskinfo=taskinfo)
                
        return render(request, 'setup/shell_result.html', locals())
