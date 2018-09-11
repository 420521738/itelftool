#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django import forms
from django.contrib import auth
from assets.myauth import UserProfile
import re
from accounts.models import RoleList
from accounts.models import PermissionList


# 用于html页面as_p产生相对格式，这个是增加用户的表单
class AddUserForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ('email','password','name', 'role', 'is_active')
        widgets = {
            'email': forms.TextInput(attrs={'class': ' form-control'}),
            'password': forms.PasswordInput(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'role': forms.Select(attrs={'class': 'form-control'}),
            'is_active': forms.Select(choices=((True, u'启用'),(False, u'禁用')), attrs={'class': 'form-control'}),
        }

    def __init__(self,*args,**kwargs):
        super(AddUserForm, self).__init__(*args,**kwargs)
        self.fields['email'].label = u'邮 箱（用户唯一标志）'
        self.fields['email'].error_messages = {'required': u'请输入邮箱', 'invalid': u'请输入有效邮箱'}
        
        self.fields['password'].label = u'密 码'
        self.fields['password'].error_messages={'required': u'请输入密码'}
        
        self.fields['name'].label = u'中文名字'
        self.fields['name'].error_messages = {'required': u'请输入账号'}
        self.fields['role'].label = u'权限角色'
        self.fields['is_active'].label = u'状 态'

    def clean_password(self):
        password = self.cleaned_data.get('password')
        if len(password) < 6:
            raise forms.ValidationError(u'密码必须大于6位')
        return password


# 用于html页面as_p产生相对格式，这个是编辑用户的表单
class EditUserForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ('email','name', 'role', 'is_active')
        widgets = {
            'email': forms.TextInput(attrs={'class': 'form-control', 'style': 'width:500px;'}),
            'name': forms.TextInput(attrs={'class': 'form-control', 'style': 'width:500px;'}),
            'role': forms.Select(attrs={'class': 'form-control', 'style': 'width:500px;'}),
            'is_active': forms.Select(choices=((True, u'启用'),(False, u'禁用')),attrs={'class': 'form-control', 'style': 'width:500px;'}),
        }

    def __init__(self,*args,**kwargs):
        super(EditUserForm,self).__init__(*args,**kwargs)
        self.fields['email'].label = u'邮 箱（用户唯一标志）'
        self.fields['email'].error_messages = {'required':u'请输入邮箱','invalid':u'请输入有效邮箱'}
        
        self.fields['name'].label = u'账 号'
        self.fields['name'].error_messages = {'required':u'请输入账号'}

        self.fields['role'].label = u'权限角色'
        self.fields['is_active'].label = u'状 态'

    def clean_password(self):
        return self.cleaned_data['password']
    

# 用于html页面as_p产生相对格式，这个是编辑管理员的表单
class EditSuperUserForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ('is_admin', 'is_superuser', 'is_active')
        widgets = {
            'is_admin': forms.Select(choices=((True, u'是'),(False, u'否')),attrs={'class': 'form-control', 'style': 'width:500px;'}),
            'is_superuser': forms.Select(choices=((True, u'是'),(False, u'否')),attrs={'class': 'form-control', 'style': 'width:500px;'}),
            'is_active': forms.Select(choices=((True, u'启用'),(False, u'禁用')),attrs={'class': 'form-control', 'style': 'width:500px;'}),
        }

    def __init__(self,*args,**kwargs):
        super(EditSuperUserForm,self).__init__(*args,**kwargs)
        self.fields['is_admin'].label = u'是否是普通管理员'
        self.fields['is_superuser'].label = u'是否是超级管理员'
        self.fields['is_active'].label = u'状 态'

    def clean_password(self):
        return self.cleaned_data['password']


# 用于html页面as_p产生相对格式，这个是更改密码的表单
class ChangePasswordForm(forms.Form):
    old_password = forms.CharField(label=u'原密码', error_messages={'required': '请输入原始密码'},
        widget=forms.PasswordInput(attrs={'class': 'form-control', 'style': 'width:500px;'}))
    new_password1 = forms.CharField(label=u'新密码', error_messages={'required': '请输入新密码'},
        widget=forms.PasswordInput(attrs={'class': 'form-control', 'style': 'width:500px;'}))
    new_password2 = forms.CharField(label=u'新密码', error_messages={'required': '请重复新输入密码'},
        widget=forms.PasswordInput(attrs={'class': 'form-control', 'style': 'width:500px;'}))

    def __init__(self, user, *args, **kwargs):
        self.user = user
        super(ChangePasswordForm, self).__init__(*args, **kwargs)

    def clean_old_password(self):
        old_password = self.cleaned_data["old_password"]
        if not self.user.check_password(old_password):
            raise forms.ValidationError(u'原密码错误')
        return old_password

    def clean_new_password2(self):
        password1 = self.cleaned_data.get('new_password1')
        password2 = self.cleaned_data.get('new_password2')
        #if len(password1)<6:
        #    raise forms.ValidationError(u'密码必须大于6位')
        #This 检查密码复杂度
        if re.match(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])\w{6,}$',password1):
            return True
        else:
            raise forms.ValidationError(u'密码必须由6个或以上的普通字符组成，必须有一个或以上数字，一个或以上英文小写字母，一个或以上英文大写字母！')

        if password1 and password2:
            if password1 != password2:
                raise forms.ValidationError(u'两次密码输入不一致')
        return password2

    def save(self, commit=True):
        self.user.set_password(self.cleaned_data['new_password1'])
        if commit:
            self.user.save()
        return self.user


# 用于html页面as_p产生相对格式，这个是展示角色列表的表单
class RoleListForm(forms.ModelForm):
    class Meta:
        model = RoleList
        exclude = ("id",)
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'permission': forms.SelectMultiple(attrs={'class': 'form-control', 'size':'10', 'multiple': 'multiple'}),
        }

    def __init__(self,*args,**kwargs):
        super(RoleListForm,self).__init__(*args, **kwargs)
        self.fields['name'].label = u'名 称'
        self.fields['name'].error_messages = {'required': u'请输入名称'}
        self.fields['permission'].label = u'URL'
        self.fields['permission'].required = False


# 用于html页面as_p产生相对格式，这个是展示权限列表的表单
class PermissionListForm(forms.ModelForm):
    class Meta:
        model = PermissionList
        exclude = ("id",)
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'url': forms.TextInput(attrs={'class': 'form-control'}),
        }

    def __init__(self, *args, **kwargs):
        super(PermissionListForm, self).__init__(*args, **kwargs)
        self.fields['name'].label = u'名 称'
        self.fields['name'].error_messages = {'required':u'请输入名称'}
        self.fields['url'].label = u'URL(如/accounts/xxx)'
        self.fields['url'].error_messages = {'required':u'请输入URL'}
