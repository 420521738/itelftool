#! /usr/bin/env python
# -*- coding: utf-8 -*-

from assets.models import Asset, HostGroup, NIC
from django.shortcuts import render
from subprocess import Popen, PIPE
import pbs
from config.views import get_dir
from django.contrib.auth.decorators import login_required
#from lib.log import log
from lib.setup import get_scripts
import logging
from _mysql import NULL


scripts_dir = get_dir("s_path")
level = get_dir("log_level")
log_path = get_dir("log_path")
#log("setup.log", level, log_path)


@login_required()
def index(request):
    all_host = Asset.objects.all()
    all_group = HostGroup.objects.all()
    all_scripts = get_scripts(scripts_dir)
    return render(request, 'setup/shell.html', locals())


@login_required()
def exec_scripts(request):
    logging.basicConfig(filename='C:\\Users\\Administrator\\eclipse-workspace\\itelftool\\data\\logs\\setup.log',level=logging.INFO,format='%(asctime)s %(levelname)s %(message)s',datefmt='%Y%m%d %H:%M:%S')
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
                            # windows开发环境下需要进行的路径字符串替换，如果是在linux下根本不需要这么写，直接调用sh模块调用命令就行了
                            temp_scripts_dir = scripts_dir.replace('\\\\','/')
                            scriptsdir = temp_scripts_dir.replace(':','')
                            scpcmd = "scp "+"/cygdrive/"+scriptsdir+s+" "+"chenqiufei@{}:/tmp/".format(ip)+s
                            scp_p = Popen(scpcmd, stdout=PIPE, stderr=PIPE, shell=True)
                            data = scp_p.communicate()
                            ret.append(data)
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
                        #print('cmd',cmd)
                        p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                        data = p.communicate()
                        ret.append(data)
                        logging.info("command:"+cmd)
                        for d in data:
                            logging.info(d)
                    logging.info("==========Shell End============")
        if group:
            if scripts:
                for g in group:
                    logging.info("==========Script Start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("Group:"+g)
                    get_group = HostGroup.objects.get(name=g)
                    hosts = get_group.serverList.all() 
                    # 表结构适配，从group里面获取到assetid,serverlist是整理后的资产列表
                    serverlist = []
                    for server in hosts:
                        obj = Asset.objects.get(id=server.id)
                        serverlist.append(server)
                    #print(serverlist)
                    ret.append(g)
                    
                    for asset in serverlist:
                        nicinfo = NIC.objects.get(asset_id = asset.id)
                        ip = nicinfo.ipaddress
                        ret.append(asset.name)
                        for s in scripts:
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
                            cmd = "ssh chenqiufei@"+ip+" "+'"sh /tmp/{} {}"'.format(s, args)
                            p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                            data = p.communicate()
                            ret.append(data)
                            logging.info("command:"+cmd)
                            for d in data:
                                logging.info(d)
                    logging.info("==========Script End============")
            else:
                command_list = []
                command_list = command.split('\n')
                for g in group:
                    logging.info("==========Shell Start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("Group:"+g)
                    get_group = HostGroup.objects.get(name=g)
                    hosts = get_group.serverList.all()
                    # 表结构适配，从group里面获取到assetid,serverlist是整理后的资产列表
                    serverlist = []
                    for server in hosts:
                        obj = Asset.objects.get(id=server.id)
                        serverlist.append(server)
                    #print(serverlist)
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
        return render(request, 'setup/shell_result.html', locals())
