#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from django.db import models
from assets.models import Asset


class test(models.Model):
    name = models.CharField(u"测试字段", max_length=40, unique=True, null=False, blank=False)

    def __str__(self):
        return self.name