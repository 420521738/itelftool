#! /usr/bin/env python
# -*- coding: utf-8 -*-
from assets.models import Asset, HostGroup, NIC
from django.shortcuts import render
from subprocess import Popen, PIPE
import sh
from config.views import get_dir
from django.contrib.auth.decorators import login_required
from lib.log import log
from lib.setup import get_files
import logging
from accounts.permission import permission_verify

filetransfer_dir = get_dir("f_path")
level = get_dir("log_level")
log_path = get_dir("log_path")
log("setup.log", level, log_path)


@login_required()
@permission_verify()
def index(request):
    all_host = Asset.objects.all()
    all_group = HostGroup.objects.all()
    all_file = get_files(filetransfer_dir)
    return render(request, 'setup/file.html', locals())


@login_required()
@permission_verify()
def exec_filetransfer(request):
    ret = []
    if request.method == 'POST':
        server = request.POST.getlist('mserver', [])
        group = request.POST.getlist('mgroup', [])
        files = request.POST.getlist('mfiles', [])
        args = request.POST.get('margs')
        if args is not None:
            pass
        else:
            args = "/tmp/"
        if server:
            for name in server:
                host = Asset.objects.get(name=name)
                nicinfo = NIC.objects.get(asset_id = host.id)
                ip = nicinfo.ipaddress
                ret.append(host.name)
                logging.info("==========FileTransfer Start==========")
                logging.info("User:"+request.user.name)
                logging.info("Host:"+host.name)
                fileall = ""
                for file in files:
                    fileall = fileall+file+","
                fileall = fileall.rstrip(',')
                if len(files) ==0:
                    ret.append("未选择文件，本次操作无文件传输！")
                else:
                    if len(files) ==1:
                        cmd = "rsync -avz "+filetransfer_dir+fileall+" chenqiufei@{}:".format(ip)+args
                    else:
                        cmd = "rsync -avz "+filetransfer_dir+"{"+fileall+"} "+"chenqiufei@{}:".format(ip)+args
                    p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                    data = p.communicate()
                    ret.append(data)
                    logging.info("transfer files: "+"{"+fileall+"} "+"to "+ip+" path:"+args)
                    for d in data:
                        logging.info(d)
                logging.info("==========FileTransfer End============")
        if group:
            for g in group:
                logging.info("==========FileTransfer Start==========")
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
                    fileall = ""
                    for file in files:
                        fileall = fileall+file+","
                    fileall = fileall.rstrip(',')
                    if len(files) ==0:
                        ret.append("未选择文件，本次操作无文件传输！")
                    else:
                        if len(files) ==1:
                            cmd = "rsync -avz "+filetransfer_dir+fileall+" chenqiufei@{}:".format(ip)+args
                        else:
                            cmd = "rsync -avz "+filetransfer_dir+"{"+fileall+"} "+"chenqiufei@{}:".format(ip)+args
                        p = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                        data = p.communicate()
                        ret.append(data)
                        logging.info("transfer files: "+"{"+fileall+"} "+"to "+ip+" path:"+args)
                        for d in data:
                            logging.info(d)
                logging.info("==========FileTransfer End============")
        return render(request, 'setup/filetrans_result.html', locals())