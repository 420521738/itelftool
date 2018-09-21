#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from django.db import models
from appconf.models import Product, Project



class webshell(models.Model):
    ipaddr = models.GenericIPAddressField(u'服务器IP', unique=True, blank=False, null=False)
    username= models.CharField(u"用户名", max_length=50, null=False, blank=False)
    password = models.CharField(u"密码", max_length=50, null=False, blank=False)
    port = models.IntegerField(u"SSH端口", default=22, null=True, blank=True)
    
    product = models.ForeignKey(
            Product,
            null=True,
            blank=True,
            verbose_name=u"所属产品线"
    )
    
    project = models.ForeignKey(
            Project,
            null=True,
            blank=True,
            verbose_name=u"所属项目"
    )
    
    memo = models.TextField(u'备注', null=True, blank=True)

    def __str__(self):
        return self.ipaddr