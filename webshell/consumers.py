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
        while not self.chan.chan.exit_status_ready():
            time.sleep(0.1)
            try:
                data = self.chan.chan.recv(1024)
                async_to_sync(self.chan.channel_layer.group_send)(
                    'chenqiufei',
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
        async_to_sync(self.channel_layer.group_add)('chenqiufei', self.channel_name)
        self.accept()
        
    def get_text_data(self):
        pass

    def receive(self, text_data):
        try:
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
                self.chan.send(text_data)
            except Exception as ex:
                print(str(ex))

    def user_message(self, event):
        self.send(text_data=event["text"])

    def disconnect(self, close_code):
        async_to_sync(self.channel_layer.group_discard)('chenqiufei', self.channel_name)
