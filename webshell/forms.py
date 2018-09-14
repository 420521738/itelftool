#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django import forms
from django.forms.widgets import *
from webshell.models import webshell


class WebshellForm(forms.ModelForm):
    class Meta:
        model = webshell
        fields = ('ipaddr','username','password', 'port', 'product', 'project')
        exclude = ("id",)
        widgets = {
            'ipaddr': TextInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'username': TextInput(attrs={'class': 'form-control','style': 'width:450px'}),
            'password': PasswordInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'port': NumberInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'product': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'project': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
        }
        
    def __init__(self,*args,**kwargs):
        super(WebshellForm, self).__init__(*args,**kwargs)
        self.fields['ipaddr'].label = u'服务器IP'
        self.fields['ipaddr'].error_messages = {'required': u'请输入服务器IP地址', 'invalid': u'请输入合法IP地址'}
        
        self.fields['username'].label = u'登录用户'
        self.fields['username'].error_messages={'required': u'请输入用户名'}
        
        self.fields['password'].label = u'登录密码'
        self.fields['password'].error_messages = {'required': u'请输入密码'}
        
        self.fields['port'].label = u'ssh端口（默认22）'
        self.fields['port'].error_messages = {'invalid': u'请输入整形端口号'}
        
        self.fields['product'].label = u'服务器所属产品线'
        
        self.fields['project'].label = u'服务器所属项目'
        
    def clean_password(self):
        password = self.cleaned_data.get('password')
        if len(password) < 6:
            raise forms.ValidationError(u'密码必须大于6位')
        return password



class WebshellFormServerLogin(forms.ModelForm):
    class Meta:
        model = webshell
        fields = ('ipaddr','username','password', 'port')
        exclude = ("id",)
        widgets = {
            'ipaddr': TextInput(attrs={'class': 'form-control','style': 'width:180px;'}),
            'username': TextInput(attrs={'class': 'form-control','style': 'width:180px'}),
            'password': PasswordInput(attrs={'class': 'form-control','style': 'width:180px;'}),
            'port': NumberInput(attrs={'class': 'form-control','style': 'width:180px;'}),
        }
        
    def __init__(self,*args,**kwargs):
        super(WebshellFormServerLogin, self).__init__(*args,**kwargs)
        self.fields['ipaddr'].label = u'服务器IP'
        self.fields['ipaddr'].error_messages = {'required': u'请输入服务器IP地址', 'invalid': u'请输入合法IP地址'}
        
        self.fields['username'].label = u'登录用户'
        self.fields['username'].error_messages={'required': u'请输入用户名'}
        
        self.fields['password'].label = u'登录密码'
        self.fields['password'].error_messages = {'required': u'请输入密码'}
        
        self.fields['port'].label = u'ssh端口（默认22）'
        self.fields['port'].error_messages = {'invalid': u'请输入整形端口号'}