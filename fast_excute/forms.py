#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
from django import forms
from django.forms import widgets
from fast_excute.models import Fastexcude


class FastexcudeFrom(forms.ModelForm):

    class Meta:
        model = Fastexcude
        # This 设置了只需要填写以下4个字段便可以创建一个上线任务
        fields = ('name','description','server', 'shell')
        exclude = ("id",)

        widgets = {
            'name': widgets.TextInput(attrs={'class': 'form-control', 'style': 'width:450px;'}),
            'description': widgets.Textarea(attrs={'class': 'form-control', 'style': 'width:450px; height:100px'}),
            # This 这是一个单选框
            'server': widgets.Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'shell': widgets.Textarea(attrs={'class': 'form-control', 'style': 'width:450px; height:100px'}),
        }
