#!/usr/bin/env python
#coding:utf-8


from assets import models
from django.db.models import Count
import random

class AssetDashboard(object):
    '''首页画图需要的数据都在这里生产'''
    def __init__(self,reqeust):
        self.requeset = reqeust
        self.asset_list = models.Asset.objects.all()
        self.data = {}

    def searilize_page(self):
        '''生成页面需要的数据'''
        self.data['asset_categories'] = self.get_asset_categories()
        self.data['asset_status_list'] = self.get_asset_status_statistics()
        self.data['business_load'] = self.get_business_load()

    def get_business_load(self):
        '''调用监控等系统，得到每个业务线的负载率'''

        dataset = {
            'names':[],
            'data':{'load':[], 'left':[]} #left是为了填充百分比用的
        }
        
        # 在这里的负载数据是random产生的，没有意义,到时候要根据监控系统返回获取数据就有用了
        for obj in models.BusinessUnit.objects.filter(parent_level=None):
            load_val = random.randint(1,100) #这是个模拟数据，模拟各业务线的使用率负载
            dataset['names'].append(obj.name)
            dataset['data']['load'].append(load_val)
            dataset['data']['left'].append(100-load_val)
        # 返回的数据类似于：{'data': {'left': [29, 26], 'load': [71, 74]}, 'names': ['员工电脑', '测试服']}
        #print('business load ',dataset)
        return dataset
    def get_asset_status_statistics(self):
        '''资产状态分类统计'''
        queryset = list( self.asset_list.values('status').annotate(value=Count('status')))
        dataset = {
            'names':[],
            'data':[]
        }
        for index,item in enumerate(queryset):
            for db_val, display_name in models.Asset.status_choices:
                if db_val == item['status']:
                    queryset[index]['name'] = display_name
                    if db_val ==0:#online
                        queryset[index]['itemStyle'] ={
                                    'normal': {'color': 'yellowgreen'}
                                }
                        #queryset[index]['selected'] = True

        #print(queryset)
        dataset['names'] = [item['name'] for item in queryset]
        dataset['data'] = queryset
        # 返回的数据类似于：{'data': [{'value': 2, 'name': '在线', 'itemStyle': {'normal': {'color': 'yellowgreen'}}, 'status': 0}], 'names': ['在线']}
        #print('dataset2222222222222',dataset)
        return dataset
    
    def get_asset_categories(self):
        '''按资产类型进行分类'''

        dataset ={
            'names':[],
            'data':[]
        }
        prefetch_data = {
            models.Server:None,
            models.NetworkDevice:None,
            models.SecurityDevice:None,
            models.Software:None,
        }
        for key in prefetch_data:
            data_list =  list(key.objects.values('sub_asset_type').annotate(total=Count('sub_asset_type')))
            for index,category in enumerate(data_list):
                for db_val,display_name in key.sub_assset_type_choices:
                    if category['sub_asset_type'] == db_val:
                        data_list[index]['name'] =  display_name

            for item in data_list:
                dataset['names'].append(item['name'])
                dataset['data'].append(item['total'])
            #prefetch_data[key] = data_list
        #print('dataset111111111111111',dataset)
        # 返回的数据类似：{'data': [2], 'names': ['PC服务器']}
        return dataset
        # print("prefecth data",prefetch_data)
        # print("dataset",dataset)