# itelftool IT精灵工具 #

注意：本工具基于 python3.5.4版本，Django1.11.14版本前提进行开发。本工具开发调试均在谷歌浏览器下进行，所以建议使用谷歌浏览器进行访问。测试后发现，火狐浏览器也是可以正常访问的，所以首选推荐谷歌浏览器，其次是火狐浏览器。

本项目集成了网站导航、故障记录、资产管理、机房管理、应用管理、任务编排（集成ansible，任务调度celery）、便捷执行（代码发布上线）、Webshell（web界面ssh，含一键登录实时交互）、zabbix报表生成管理、用户管理、域名管理等功能。

作者QQ：420521738，添加时请备注原因，很欢迎各位加我一起探讨学习。


## 项目介绍

### 1.登录

* 帐号登录功能，结合了验证码输入功能，防止恶意尝试密码行为。

##### 登录效果截图：
![Login](https://github.com/420521738/itelftool/blob/master/screenshots/Login.png)


### 2.首页面板

* 首页暂时显示的模块内容有：月用户活跃度、服务器在线率、月业务故障率、月资产信息变更率、用户总数、用户在线数、资产总数、机房总数、产品线总数、项目总数、系统登录记录（最近10次）、版本发布记录（最近10次）、资产信息变更记录（最近10次）

##### 面板首页效果截图：
![Dashboard](https://github.com/420521738/itelftool/blob/master/screenshots/Dashboard.png)


### 3.站点导航

* 包括站点一览与站点管理功能。其中站点一览是展示我们现有的二级域名网站（包括网站描述与网络url，点击即可直达网站）；站点管理是展示内容的增删改查。

##### 站点一览效果截图：
![WebsiteNavi](https://github.com/420521738/itelftool/blob/master/screenshots/WebsiteNavi.png)
##### 站点编辑效果截图：
![WebsiteManagement](https://github.com/420521738/itelftool/blob/master/screenshots/WebsiteManagement.png)


### 4.故障记录

* 故障记录功能。故障记录对于一个运维团队在处理故障方面的成长是有必要的，传统的故障记录可能是Excel记录或者Word文档记录，不方便查询与统计。这里的故障记录功能可以有效定义相关字段进行记录，可以筛选，可以导出，也可以动态计算本月故障率，并在首页面板上进行展示，无需人为计算故障率。

##### 故障记录效果截图：
![BrokenRecord](https://github.com/420521738/itelftool/blob/master/screenshots/BrokenRecord.png)


### 5.资产菜单

* 该资产菜单功能包括：资产列表，事件中心，机房管理，机柜管理，属组管理。

##### 资产列表效果截图：
![AssetsList](https://github.com/420521738/itelftool/blob/master/screenshots/AssetsList.png)


### 6.应用管理

* 该应用管理功能包括：产品线管理，项目管理，运维负责人管理，开发负责人管理。

##### 项目管理效果截图：
![AppManagement](https://github.com/420521738/itelftool/blob/master/screenshots/AppManagement.png)


### 7.任务编排

* 该任务编排功能包括：Shell命令执行、Ansible执行（包括角色和剧本均已适配）、文件上传、文件分发、任务调度（Celery实现）、任务执行记录。

##### Ansible执行效果截图：
![TaskSche](https://github.com/420521738/itelftool/blob/master/screenshots/TaskSche.png)


### 8.便捷执行（代码发布功能）

* 该便捷执行功能包括：代码发布，执行记录。其中代码发布状态实时更新，更新日志也可以在web上实时输出；代码发布记录可查，更新过程输出均保存到数据库，方便日后可查。
* 可以一键发布指定项目程序上线，上线步骤可分步依次执行，可以实时查看日志，执行状态实时更新，执行记录可查，保存每次更新的过程日志，其中涉及到更新了什么文件以及版本变更，出了问题可溯源。

##### 代码发布管理效果截图：
![coderelease](https://github.com/420521738/itelftool/blob/master/screenshots/coderelease.png)
##### 代码发布日志实时查看效果截图：
![coderelease_log](https://github.com/420521738/itelftool/blob/master/screenshots/coderelease_log.png)
##### 执行记录效果截图：
![cod_excute_record](https://github.com/420521738/itelftool/blob/master/screenshots/cod_excute_record.png)
##### 更新日志查看（方便溯源）效果截图：
![coderelease_logdetail](https://github.com/420521738/itelftool/blob/master/screenshots/coderelease_logdetail.png)


### 9.Webshell

* 该Webshell功能包括：登录管理（增删改查登录服务器项，可实现一键登录）、帐号密码登录接口。
* 基于websocket的webshell，可以在电脑或者手机上通过浏览器一键登录服务器，也可以通过帐号密码方式登录服务器，都是可选的。

##### 登录管理效果截图：
![LoginManagement](https://github.com/420521738/itelftool/blob/master/screenshots/LoginManagement.png)
##### 电脑WebShell界面效果截图：
![PcWebshell](https://github.com/420521738/itelftool/blob/master/screenshots/PcWebshell.png)
##### 手机WebShell界面效果截图：
![PhoneWebshell](https://github.com/420521738/itelftool/blob/master/screenshots/PhoneWebshell.png)


### 10.Zabbix管理

* 该Zabbix管理功能包括：监控项id查阅，监控图组管理，生成数据报表。
* 其中监控id查阅，是方便用户记录需要的监控图id，用来建立监控图组，最后生成数据报表。除了可以手动输入监控图id列表以外，我还提供了创建监控图组的方式来保存监控id列表到数据库中，我们的统计一般情况下是不会有太大的数据来源变化，因此建议使用监控图组的方式去创建生成数据报表更为简单快捷。

##### 输入zabbix报表生成三要素效果截图：
![ZabbixInputInfo](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixInputInfo.png)
##### 上传无法调用zabbix接口获取的监控图像效果截图：
![ZabbixReportUpload](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixReportUpload.png)
##### 数据报表自动下载效果截图：
![ZabbixReportDownload](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixReportDownload.png)
##### 数据报表效果截图：
![ZabbixReportExample](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixReportExample.png)


### 11.用户管理

* 该用户管理功能包括：用户管理（用户增删改查）、用户角色管理、权限管理、管理员设定、在线用户列表。

##### 用户管理效果截图：
![UserManagement](https://github.com/420521738/itelftool/blob/master/screenshots/UserManagement.png)


### 12.域名管理

* 该域名管理功能包括：域名信息（记录在数据库中，可点击同步按钮更新数据库中的域名信息）、实时查询域名信息（接口，输入域名即可查询到域名相关信息）。

##### 域名管理面板效果截图：
![DomainManagement](https://github.com/420521738/itelftool/blob/master/screenshots/DomainManagement.png)
##### 域名实时查询功能效果截图：
![DomainSearchResult](https://github.com/420521738/itelftool/blob/master/screenshots/DomainSearchResult.png)



## 项目安装
未完待续，在撰写中，请耐心等待。




