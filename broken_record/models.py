#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from django.db import models
from assets.models import Asset
from appconf.models import AppOwner, Product, Project


class Developer(models.Model):
    name = models.CharField(u"开发人员", max_length=50, unique=True, null=False, blank=False)
    phone = models.CharField(u"开发人员手机", max_length=50, null=False, blank=False)
    qq = models.CharField(u"开发人员QQ", max_length=100, null=True, blank=True)
    weChat = models.CharField(u"开发人员微信", max_length=100, null=True, blank=True)

    def __str__(self):
        return self.name
    

class BrokenRrecord(models.Model):
    BROKEN_TYPES = (
        (u"网络", u"网络"),
        (u"CDN缓存", u"CDN缓存"),
        (u"数据库", u"数据库"),
        (u"Web容器", u"Web容器"),
        (u"安全漏洞", u"安全漏洞"),
        (u"中间件", u"中间件"),
        (u"操作系统", u"操作系统"),
        (u"域名", u"域名"),
        (u"硬件", u"硬件"),
        (u"其他", u"其他"),
    )

    SEVERITY_TYPE = (
        (u"非常高", u"非常高"),
        (u"高", u"高"),
        (u"中", u"中"),
        (u"低", u"低"),
    )

    BROKEN_STATUS_TYPE = (
        (u"已解决", u"已解决"),
        (u"处理中", u"处理中"),
        (u"搁置中", u"搁置中"),
    )

    BROKEN_DEPARTMENT = (
        (u"运维部", u"运维部"),
        (u"星星打车技术部", u"星星打车技术部"),
        (u"其他", u"其他"),
    )

    name = models.CharField(u"故障名称", max_length=50, unique=True, null=False, blank=False)
    description = models.CharField(u"故障描述", max_length=1024, null=False, blank=False)
    process_description = models.CharField(u"处理过程", max_length=1024, null=False, blank=False)
    precaution = models.CharField(u"预防措施", max_length=1024, null=True, blank=True)
    broken_type = models.CharField(u"故障类型", choices=BROKEN_TYPES, max_length=30, null=False, blank=False)
    severity_type = models.CharField(u"故障严重性", choices=SEVERITY_TYPE, max_length=30, null=False, blank=False)
    broken_status_type = models.CharField(u"故障状态类型", choices=BROKEN_STATUS_TYPE, max_length=30, null=False, blank=False)
    broken_department = models.CharField(u"故障主要归属部门", choices=BROKEN_DEPARTMENT, max_length=30, null=False, blank=False)
    occur_time = models.DateTimeField(u'故障发生时间', null=False, blank=False)
    end_time = models.DateTimeField(u'故障结束时间', null=False, blank=False)
    business_impact_time = models.CharField(u"业务影响时间", max_length=50, null=False, blank=False)
    update_date = models.DateTimeField(blank=True, auto_now=True)
    
    maintenance = models.ForeignKey(
            AppOwner,
            null=True,
            blank=True,
            verbose_name=u"运维主要处理人"
    )

    developer = models.ForeignKey(
            Developer,
            null=True,
            blank=True,
            verbose_name=u"开发主要处理人"
    )

    product = models.ForeignKey(
            Product,
            null=False,
            blank=False,
            verbose_name=u"所属产品线"
    )
    
    project = models.ForeignKey(
            Project,
            null=False,
            blank=False,
            verbose_name=u"所属项目"
    )

    def __unicode__(self):
        return self.name
