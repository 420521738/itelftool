#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django import forms
from zabbix.models import MonitorGraph


# 用于html页面as_p产生相对格式，这个是展示角色列表的表单
class GraphGroupForm(forms.ModelForm):
    class Meta:
        model = MonitorGraph
        exclude = ("id",)
        widgets = {
            'groupname': forms.TextInput(attrs={'class': 'form-control'}),
            'graphids': forms.Textarea(attrs={'class': 'form-control'}),
        }

    def __init__(self,*args,**kwargs):
        super(GraphGroupForm,self).__init__(*args, **kwargs)
        self.fields['groupname'].label = u'监控图组名称'
        self.fields['groupname'].error_messages = {'required': u'请输入监控图组名称'}
        self.fields['graphids'].label = u'成员图片id（逗号分隔）'
        self.fields['graphids'].error_messages = {'required': u'成员图片id，使用逗号分隔'}
