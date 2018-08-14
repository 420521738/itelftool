#! /usr/bin/env python
# -*- coding: utf-8 -*-
from django.conf.urls import url, include
from setup import shell


urlpatterns = [
    url(r'^shell/$', shell.index, name='shell'),
    url(r'^scripts/exec/$', shell.exec_scripts, name='exec_scripts'),

]