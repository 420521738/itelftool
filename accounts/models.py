#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.db import models


# 权限表，说白了就是url表
class PermissionList(models.Model):
    name = models.CharField(max_length=64)
    url = models.CharField(max_length=255)

    def __str__(self):
        return '%s(%s)' % (self.name, self.url)


# 角色表，角色名和url的对应，可以是多对多的关系
class RoleList(models.Model):
    name = models.CharField(max_length=64)
    # permission = models.ManyToManyField(PermissionList, null=True, blank=True)
    permission = models.ManyToManyField(PermissionList, blank=True)

    def __str__(self):
        return self.name
