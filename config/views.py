#! /usr/bin/env python
# -*- coding: utf-8 -*-
from django.shortcuts import render, HttpResponse
try:
    import configparser as cf
except Exception as msg:
    print(msg)
    import ConfigParser as cf
import os
from django.contrib.auth.decorators import login_required
from django.contrib.auth import get_user_model
from lib.log import dic


def get_dir(args):
    config = cf.RawConfigParser()
    dirs = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    with open(dirs+'/itelftool.conf', 'r') as cfgfile:
        config.readfp(cfgfile)
        a_path = config.get('config', 'ansible_path')
        r_path = config.get('config', 'roles_path')
        p_path = config.get('config', 'playbook_path')
        s_path = config.get('config', 'scripts_path')
        token = config.get('token', 'token')
        ssh_pwd = config.get('token', 'ssh_pwd')
        log_path = config.get('log', 'log_path')
        log_level = config.get('log', 'log_level')
        mongodb_ip = config.get('mongodb', 'mongodb_ip')
        mongodb_port = config.get('mongodb', 'mongodb_port')
        mongodb_user = config.get('mongodb', 'mongodb_user')
        mongodb_pwd = config.get('mongodb', 'mongodb_pwd')
        mongodb_collection = config.get('mongodb', 'collection')
        webssh_domain = config.get('webssh', 'domain')
        redis_host = config.get('redis', 'redis_host')
        redis_port = config.get('redis', 'redis_port')
        redis_password = config.get('redis', 'redis_password')
        redis_db = config.get('redis', 'redis_db')
    # 根据传入参数返回变量以获取配置，返回变量名与参数名相同
    if args:
        return vars()[args]
    else:
        return HttpResponse(status=403)
