#!/usr/bin/env python
#coding:utf-8

"""itelftool URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""


from django.conf.urls import include, url
from django.contrib import admin
from assets import rest_urls,urls as asset_urls
from itelftool import views
from assets import VerifyCode

# 这里的url写法和django1.7之前的又有一些区别了
urlpatterns = [
    # 添加这条url的前提是由于用户认证模块是用自己修改的，修改指定id用户的密码时，会带有change的多余字段，需要把change多余字段删除，才是正确的密码修改请求
    url(r'^admin/assets/userprofile/(\d+)/change/password/', views.urlchange_passwd),
    # admin后端管理url以及指定程序，这条是默认的
    url(r'^admin/', include(admin.site.urls)),
    # 使用restful接口的api
    url(r'^api/', include(rest_urls) ),
    # 以asset开头的url均跳转到assets模块里的rest_urls,urls里
    url(r'^asset/',include(asset_urls)),
    # 站点导航url入口
    url(r'^navi/', include('navi.urls')),
    # 应用管理url入口
    url(r'^appconf/', include('appconf.urls')),
    # 用户管理url入口
    url(r'^accounts/', include('accounts.urls')),
    # 任务编排url入口
    url(r'^setup/', include('setup.urls')),
    # 故障记录入口
    url(r'^brokenrecord/', include('broken_record.urls')),
   # Webshell入口
   url(r'^webshell/', include('webshell.urls')),
   # Zabbix入口
   url(r'^zabbix/', include('zabbix.urls')),
   # This 域名管理入口
   url(r'^domain/', include('domain.urls')),
   # This 便捷执行入口
   url(r'^fastexcute/', include('fast_excute.urls')),
    # 首页
    # name，简单来说，name 可以用于在 templates，models，views ..... 中得到对应的网址，相当于给网址取了个名字，只要这个名字不变，网址变了也能通过名字获取到。
    url(r'^$',views.index,name="index"),
    # 登录页
    url(r'^login/$',views.acc_login, name='login'),
    # 验证码功能
    url(r'^verifycode/$', VerifyCode.verifycode),
    # 退出页
    url(r'^logout/$', views.logout, name='logout'),

]
