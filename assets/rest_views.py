#!/usr/bin/env python
#coding:utf-8


from assets import  myauth
from rest_framework import viewsets
from assets.serializers import UserSerializer, AssetSerializer,ServerSerializer
from rest_framework import status
from rest_framework import permissions
from rest_framework.decorators import api_view,permission_classes
from rest_framework.response import Response
from assets import models

# UserProfile 表的接口，可以以接口的形式允许用户读写
class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = myauth.UserProfile.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer

# Asset 表的接口，可以以接口的形式允许用户读写
class AssetViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Asset to be viewed or edited.
    """
    queryset = models.Asset.objects.all()
    serializer_class = AssetSerializer

# Server 表的接口，可以以接口的形式允许用户读写
class ServerViewSet(viewsets.ModelViewSet):

    queryset = models.Server.objects.all()
    serializer_class = ServerSerializer



# 调用rest_framework的装饰器下的api_view以及permission_classes
@api_view(['GET', 'POST'])
@permission_classes((permissions.AllowAny,))
def AssetList(request):
    if request.method == 'GET':
        asset_list = models.Asset.objects.all()
        serializer = AssetSerializer(asset_list,many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = AssetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
