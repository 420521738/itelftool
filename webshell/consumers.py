#!/usr/bin/env python
#coding:utf-8

from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer


import paramiko
import threading
import time
import ast

from channels.layers import get_channel_layer
channel_layer = get_channel_layer()

class MyThread(threading.Thread):
    def __init__(self, id, chan):
        threading.Thread.__init__(self)
        self.chan = chan

    def run(self):
        # This 获取channel频道的组名，只能是数字、字母、下划线，所以这里需要取邮箱地址@前面的那部分作为标识
        user_email = self.chan.scope['user'].email
        channel_group_name = user_email.split('@')[0]
        while not self.chan.chan.exit_status_ready():
            time.sleep(0.1)
            try:
                data = self.chan.chan.recv(1024)
                async_to_sync(self.chan.channel_layer.group_send)(
                    channel_group_name,
                    {
                        "type": "user.message",
                        "text": bytes.decode(data)
                    },
                )
            except Exception as ex:
                #print(str(ex))
                pass
        self.chan.sshclient.close()
        return False

class EchoConsumer(WebsocketConsumer):

    def connect(self):
        #async_to_sync(self.channel_layer.group_add)(self.scope['user'].name, self.channel_name)
        # This 创建channels group， 命名为：用户名，并使用channel_layer写入到redis
        user_email = self.scope['user'].email
        channel_group_name = user_email.split('@')[0]
        async_to_sync(self.channel_layer.group_add)(channel_group_name, self.channel_name)
        # This 返回给receive方法处理
        self.accept()
        
    def get_text_data(self):
        pass

    def receive(self, text_data):
        try:
            # This 因为页面是一个个字符传进来的，所以需要进行判断，但是在第一次打开terminal的时候，我从页面（webshell.html）上已经传入了一个info的变量，包含ip、端口、用户名、密码进行自动登录
            # This 从页面上传进来的是包含帐号、密码等信息的那个字典（传过来的是str，需要转换成dict）
            serverinfo_dict =  ast.literal_eval(text_data)
            if 'password' in serverinfo_dict:
                ipaddr = serverinfo_dict['ipaddr']
                port = serverinfo_dict['port']
                username = serverinfo_dict['username']
                password = serverinfo_dict['password']
                self.sshclient = paramiko.SSHClient()
                self.sshclient.load_system_host_keys()
                self.sshclient.set_missing_host_key_policy(paramiko.AutoAddPolicy())
                self.sshclient.connect(ipaddr, port, username, password)
                self.chan = self.sshclient.invoke_shell(term='xterm')
                self.chan.settimeout(0)
                t1 = MyThread(999, self)
                t1.setDaemon(True)
                t1.start()
        except:
            try:
                # This 如果从页面上传进来的不是包含帐号、密码等信息的那个字典（传过来的是str，需要转换成dict）
                self.chan.send(text_data)
            except Exception as ex:
                print(str(ex))

    def user_message(self, event):
        self.send(text_data=event["text"])

    def disconnect(self, close_code):
        user_email = self.scope['user'].email
        channel_group_name = user_email.split('@')[0]
        async_to_sync(self.channel_layer.group_discard)(channel_group_name, self.channel_name)
