#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from django.db import models
from webshell.models import webshell


class Fastexcude(models.Model):
    name = models.CharField(u"执行名", max_length=50, null=False, blank=False)
    description = models.CharField(u"描述", max_length=255, null=True, blank=True)
    status = models.BooleanField(verbose_name=u"执行状态", default=False)
    # This 进度条参数
    bar_data = models.IntegerField(default=0)
    # This 这里没有添加on_delete=models.SET_NULL，是因为这里不能为null，为null的话就没有意义了
    server = models.ForeignKey(
            webshell,
            null=False,
            blank=False,
            verbose_name=u"执行服务器"
    )
    shell = models.CharField(max_length=255, verbose_name=u"命令（如有多个命令，一行写一个命令，按序执行）", null=False, blank=False)
    excude_time = models.DateTimeField(u'最新执行时间', null=True, blank=True)
    update_date = models.DateTimeField(u'配置更新时间', blank=True, auto_now=True)
    
    
    def __str__(self):
        return self.name
    


class FastexcudeRecord(models.Model):
    excudename = models.CharField(u"执行项", max_length=50, null=False, blank=False)
    excudeuser = models.CharField(u"执行人", max_length=50, null=False, blank=False)
    excudeserver = models.GenericIPAddressField(u'执行服务器', blank=False, null=False)
    excude_time = models.DateTimeField(u'执行时间', null=True, blank=True)
    excudestatus = models.BooleanField(verbose_name=u"执行结果", default=False)
    excudelog = models.TextField(u'执行日志', null=True, blank=True)
    
    
    def __str__(self):
        return self.excudename


