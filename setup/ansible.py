#! /usr/bin/env python
# -*- coding: utf-8 -*-

from subprocess import Popen, PIPE
from assets.models import Asset, HostGroup
from django.shortcuts import render
from django.http import HttpResponse
import os
from config.views import get_dir
from django.contrib.auth.decorators import login_required
import logging
from lib.log import log
from lib.setup import get_playbook, get_roles
from assets.models import NIC
from accounts.permission import permission_verify

# var info
ansible_dir = get_dir("a_path")
roles_dir = get_dir("r_path")
playbook_dir = get_dir("p_path")
level = get_dir("log_level")
log_path = get_dir("log_path")
log("setup.log", level, log_path)

# 这是在判断变量不为空的时候，需要根据获取到的变量在对应的roles下创建vars/main.yml文件，并把变量写进去文件中
def write_role_vars(roles, vargs):

    r_vars = vargs.split('\r\n')
    for r in roles:

        if vargs:
            if os.path.exists(roles_dir+r+"/vars"):
                pass
            else:
                os.mkdir(roles_dir+r+"/vars")

            with open(roles_dir+r+'/vars/main.yml', 'w+') as role_file:
                role_file.writelines("---\n")
                for x in r_vars:
                    rs = x + '\n'
                    role_file.writelines(rs)
    return True


@login_required()
@permission_verify()
def index(request):
    all_host = Asset.objects.all()
    all_group = HostGroup.objects.all()
    all_dir = get_roles(roles_dir)
    all_pbook = get_playbook(playbook_dir)
    return render(request, 'setup/ansible.html', locals())


@login_required()
@permission_verify()
def playbook(request):
    ret = []
    # temp.yml是在页面选择roles时，就创建一个临时的playbook，仅做一次性执行，每次都会不一样
    if os.path.exists(ansible_dir + '/temp.yml'):
        os.remove(ansible_dir + '/temp.yml')
    else:
        pass
    if request.method == 'POST':
        host = request.POST.getlist('mserver', [])
        group = request.POST.getlist('mgroup', [])
        pbook = request.POST.getlist('splaybook', [])
        roles = request.POST.getlist('mroles', [])
        role_vars = request.POST.get('mvars')
        
        # This 如果用户在页面选择的是主机
        if host:
            # This 如果用户选择了角色，并为选择具体playbook
            if roles:
                # This 如果用户选择了角色，并且设定了变量
                if role_vars:
                    write_role_vars(roles, role_vars)
                for h in host:
                    logging.info("==========ansible tasks start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("host:"+h)
                    # This 在/etc/ansible/下创建一个临时playbook，叫做temp.yml，并往这个临时文件中写入hosts，以及角色
                    with open(ansible_dir + '/temp.yml', 'w+') as f:
                        flist = ['- hosts: '+h+'\n', '  gather_facts: true\n', '  roles:\n']
                        for r in roles:
                            rs = '    - ' + r + '\n'
                            flist.append(rs)
                            logging.info("Role:"+r)
                        f.writelines(flist)
                    # This 执行刚刚创建的临时playbook，并将输出信息记录到date中，并返回到ret里面
                    cmd = "ansible-playbook"+" " + ansible_dir+'/temp.yml'
                    p = Popen(cmd, stderr=PIPE, stdout=PIPE, shell=True)
                    data = p.communicate()
                    ret.append(data)
                    for d in data:
                        logging.info(d)
                    logging.info("==========ansible tasks end============")
            else:
                for h in host:
                    for p in pbook:
                        ret.append('===============[ Play is:'+p+' ]==============='+'\n')
                        ret.append('===============[ Objects is:'+h+' ]==============='+'\n')
                        f = open(playbook_dir + p, 'r+')
                        flist = f.readlines()
                        flist[0] = '- hosts: '+h+'\n'
                        f = open(playbook_dir + p, 'w+')
                        f.writelines(flist)
                        f.close()
                        cmd = "ansible-playbook"+" " + playbook_dir + p
                        pcmd = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                        data = pcmd.communicate()
                        ret.append(data)
                        logging.info("==========ansible tasks start==========")
                        logging.info("User:"+request.user.name)
                        logging.info("host:"+h)
                        logging.info("Playbook:"+p)
                        for d in data:
                            logging.info(d)
                        logging.info("==========ansible tasks end============")
            return render(request, 'setup/result.html', locals())

        if group:
            if roles:
                if role_vars:
                    write_role_vars(roles, role_vars)
                for g in group:
                    logging.info("==========ansible tasks start==========")
                    logging.info("User:"+request.user.name)
                    logging.info("group:"+g)
                    f = open(ansible_dir + '/temp.yml', 'w+')
                    flist = ['- hosts: '+g+'\n', '  gather_facts: true\n', '  roles:\n']
                    for r in roles:
                        rs = '    - ' + r + '\n'
                        flist.append(rs)
                        logging.info("Role:"+r)
                    f.writelines(flist)
                    f.close()
                    cmd = "ansible-playbook"+" " + ansible_dir+'/temp.yml'
                    p = Popen(cmd, stderr=PIPE, stdout=PIPE, shell=True)
                    data = p.communicate()
                    ret.append(data)
                    for d in data:
                        logging.info(d)
                    logging.info("==========ansible tasks end============")
            else:
                for g in group:
                    for p in pbook:
                        ret.append('===============[ Play is:'+p+' ]==============='+'\n')
                        ret.append('===============[ Objects is:'+g+' ]==============='+'\n')
                        f = open(playbook_dir + p, 'r+')
                        flist = f.readlines()
                        flist[0] = '- hosts: '+g+'\n'
                        f = open(playbook_dir + p, 'w+')
                        f.writelines(flist)
                        f.close()
                        cmd = "ansible-playbook"+" " + playbook_dir + p
                        pcmd = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
                        data = pcmd.communicate()
                        ret.append(data)
                        logging.info("==========ansible tasks start==========")
                        logging.info("User:"+request.user.name)
                        logging.info("Group:"+g)
                        logging.info("Playbook:"+p)
                        for d in data:
                            logging.info(d)
                        logging.info("==========ansible tasks end============")
            return render(request, 'setup/result.html', locals())


# This 如果用户在页面上选择执行ansible命令的话
@login_required()
@permission_verify()
def ansible_command(request):
    command_list = []
    ret = []
    count = 1
    if request.method == 'POST':
        mcommand = request.POST.get('mcommand')
        command_list = mcommand.split('\n')
        for command in command_list:
            # This 命令可以是多个，但是不管多少个，命令必须都是以ansible开头的才算是合法的命令
            if command.startswith("ansible"):
                p = Popen(command, stdout=PIPE, stderr=PIPE,shell=True)
                data = p.communicate()
                ret.append(data)
            else:
                data = "your command " + str(count) + "  is invalid!"
                ret.append(data)
            count += 1
            logging.info("==========ansible tasks start==========")
            logging.info("User:"+request.user.name)
            logging.info("command:"+command)
            for d in data:
                logging.info(d)
            logging.info("==========ansible tasks end============")
        return render(request, 'setup/result.html', locals())


# This 这个功能是将组以及主机都查询出来，然后按照一定的格式，将查询出来的组以及主机写入ansible的hosts文件中
@login_required()
@permission_verify()
def host_sync(request):
    group = HostGroup.objects.all()
    ansible_file = open(ansible_dir+"/hosts", "w")
    all_host = Asset.objects.all()
    for host in all_host:
        # This 因为资产表是有多个表通过外键关联的，ip信息在网卡表中，但是并非所有的网卡都会有IP地址，所以这里就先粗略获取到第一个IP地址
        nicinfo = NIC.objects.filter(asset_id = host.id)
        for i in nicinfo:
            if i.ipaddress is None:
                pass
            else:
                ip = i.ipaddress
        host_item = host.name+" "+"ansible_host="+ip+" "+"host_name="+host.name+"\n"
        ansible_file.write(host_item)
    for g in group:
        group_name = "["+g.name+"]"+"\n"
        ansible_file.write(group_name)
        get_member = HostGroup.objects.get(name=g.name)
        members = get_member.serverList.all()
        # s表结构适配，serverlist是整理后的资产列表
        serverlist = []
        for server in members:
            obj = Asset.objects.get(id=server.id)
            serverlist.append(server)
        for m in serverlist:
            group_item = m.name+"\n"
            ansible_file.write(group_item)
    ansible_file.close()
    logging.info("==========ansible tasks start==========")
    logging.info("User:"+request.user.name)
    logging.info("Task: sync cmdb info to ansible hosts")
    logging.info("==========ansible tasks end============")
    return HttpResponse("ok")