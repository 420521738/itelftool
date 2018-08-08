#!/usr/bin/env python
#coding:utf-8

import os
BaseDir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

Params = {
    "server": "192.168.7.199",
    "port":8003,
    'request_timeout':30,
    "urls":{
          "asset_report_with_no_id":"/asset/report/asset_with_no_asset_id/",
          "asset_report":"/asset/report/",
        },
    'asset_id': '%s/var/.asset_id' % BaseDir,
    'log_file': '%s/logs/run_log' % BaseDir,
    
    # 设置认证的user以及该用户与密码独立的token，该token是在数据库中这个用户中的token字段下，一一对应的，并不是乱写的
    'auth':{
        'user':'420521738@qq.com',
        'token': '420token'
        },
}
