#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from django.db import models

class MonitorGraph(models.Model):
    groupname = models.CharField(u"监控图组名称", max_length=50, unique=True, null=False, blank=False)
    graphids = models.CharField(u"成员图片id（逗号分隔）", max_length=2048, null=False, blank=False)
    
    
    def __str__(self):
        return self.groupname