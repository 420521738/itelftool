#!/usr/bin/env python
#coding:utf-8


from django.conf.urls import url, include
from rest_framework import routers
from assets import rest_views as views
from assets import views as asset_views

# 以下是rest_framework调用使用的语法
# 产生以下三个接口：
# "users": "http://xxxx/api/users/",
# "assets": "http://xxxx/api/assets/",
# "servers": "http://xxxx/api/servers/"
router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'assets', views.AssetViewSet)
router.register(r'servers', views.ServerViewSet)


from assets import rest_test
# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    # rest_framework的3个接口的url规则
    url(r'^', include(router.urls)),
    # 资产列表，上面已经将assets下的rest_views做了别名为views,实际上是去找rest_views.AssetList
    url(r'asset_list/$',views.AssetList ),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^eventlogs/$', rest_test.eventlog_list),
]