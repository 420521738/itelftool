#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from django.db import models


# 建域名信息表，用于保存爬取回来的域名信息
class DomainRrecord(models.Model):
    # comment 域我设置了唯一性，所以不能添加相同的域
    comment = models.CharField(u"域", max_length=50, unique=True, null=False, blank=False)
    name = models.CharField(u"域名地址", max_length=50, null=False, blank=False)
    ctime = models.DateTimeField(u'域名创建时间', null=False, blank=False)
    etime = models.DateTimeField(u'域名过期时间', null=False, blank=False)
    ip = models.GenericIPAddressField(u'域名解析IP', blank=False, null=False)
    ip_source = models.CharField(u"解析IP来源", max_length=50, null=True, blank=True)
    domain_record_num = models.CharField(u"域名备案号", max_length=50, null=True, blank=True)
    domain_nature = models.CharField(u"域名性质", max_length=50, null=True, blank=True)
    domain_company = models.CharField(u"域名所属公司", max_length=50, null=True, blank=True)

    def __str__(self):
        return self.comment
