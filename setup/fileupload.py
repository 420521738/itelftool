#! /usr/bin/env python
# -*- coding: utf-8 -*-
from assets.models import Asset, HostGroup, NIC
from django.shortcuts import render,HttpResponse
from subprocess import Popen, PIPE
import os
from config.views import get_dir
from django.contrib.auth.decorators import login_required
from lib.log import log
from lib.setup import get_files
import logging
uploadfile_dir = get_dir("f_path")
level = get_dir("log_level")
log_path = get_dir("log_path")
log("setup.log", level, log_path)


@login_required()
def index(request):
    return render(request, 'setup/fileupload.html', locals())


@login_required()
def fileupload_result(request):
    if request.method == "POST":    # 请求方法为POST时，进行处理  
        myFiles =request.FILES.getlist("myfile", None)    # 获取上传的文件，如果没有文件，则默认为None  
        if not myFiles:  
            return HttpResponse("no files for upload!")  
        for myFile in myFiles:
            destination = open(os.path.join(uploadfile_dir,myFile.name),'wb+')    # 打开特定的文件进行二进制的写操作  
            for chunk in myFile.chunks():      # 分块写入文件  
                destination.write(chunk)  
            destination.close()
        status = 1
        return render(request, 'setup/fileupload_result.html', locals())    
