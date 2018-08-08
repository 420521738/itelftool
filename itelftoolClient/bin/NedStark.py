#!/usr/bin/env python
#coding:utf-8

import os,sys,platform

# 判断操作系统平台是windows还是linux
if platform.system() == "Windows":
    BASE_DIR = '\\'.join(os.path.abspath(os.path.dirname(__file__)).split('\\')[:-1])
    # 如果是windows，BASE_DIR则是 C:\Users\Administrator\eclipse-workspace\MadKing\MadKingClient
    #print(BASE_DIR)
else:
    BASE_DIR = '/'.join(os.path.abspath(os.path.dirname(__file__)).split('/')[:-1])
    # 如果是Linux，BASE_DIR则是 /root/MadKingClient
    #print(BASE_DIR)
# 添加程序执行路径，方便后续的程序进行导入模块的操作
sys.path.append(BASE_DIR)

from core import HouseStark

if __name__ == '__main__':
    # 执行HouseStark的ArgvHandler方法
    HouseStark.ArgvHandler(sys.argv)