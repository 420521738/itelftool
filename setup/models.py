#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals

from django.db import models

# Create your models here.

class TaskRecord(models.Model):
    tasktype = models.CharField(u"任务类型", max_length=50, null=False, blank=False)
    taskuser = models.CharField(u"执行人", max_length=50, null=False, blank=False)
    tasktime = models.DateTimeField(u'执行时间', null=False, blank=False)
    taskstatus = models.BooleanField(verbose_name=u"执行结果", default=False)
    taskinfo = models.TextField(u"执行详情", null=False, blank=False)
    
    
    def __str__(self):
        return self.tasktype