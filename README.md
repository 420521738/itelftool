# itelftool IT精灵工具 #

注意：本工具基于 python3.5.4版本，Django1.11.14版本前提进行开发。本工具开发调试均在谷歌浏览器下进行，所以建议使用谷歌浏览器进行访问。测试后发现，火狐浏览器也是可以正常访问的，所以首选推荐谷歌浏览器，其次是火狐浏览器。

本项目集成了网站导航、故障记录、资产管理、机房管理、应用管理、任务编排（集成ansible，任务调度celery）、便捷执行（代码发布上线）、Webshell（web界面ssh，含一键登录实时交互）、zabbix报表生成管理、用户管理、域名管理等功能。


## 项目介绍

### 1.面板首页

* 首页暂时显示的模块内容有：月用户活跃度、服务器在线率、月业务故障率、月资产信息变更率、用户总数、用户在线数、资产总数、机房总数、产品线总数、项目总数、系统登录记录（最近10次）、版本发布记录（最近10次）、资产信息变更记录（最近10次）

##### 效果截图：
![image](https://github.com/420521738/itelftool/blob/master/screenshots/Dashboard.png)

站点导航以及站点管理面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/WebsiteNavi.png)
![image](https://github.com/420521738/itelftool/blob/master/screenshots/WebsiteManagement.png)
<br/><br/>

故障记录面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/BrokenRecord.png)
<br/><br/>

资产菜单面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/AssetsList.png)
<br/><br/>

应用管理面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/AppManagement.png)
<br/><br/>

任务编排面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/TaskSche.png)
<br/><br/>

用户管理面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/UserManagement.png)
<br/><br/>

WebShell登录管理：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/LoginManagement.png)
<br/>电脑WebShell界面：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/PcWebshell.png)
<br/>手机WebShell界面：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/PhoneWebshell.png)
<br/><br/>

域名管理面板：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/DomainManagement.png)
<br/><br/>
域名实时查询功能展示：<br/><br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/DomainSearchResult.png)
<br/><br/>

便捷执行（代码发布）管理面板：<br/>
可以一键发布指定项目程序上线，上线步骤可分步依次执行，可以实时查看日志，执行状态实时更新，执行记录可查，保存每次更新的过程日志，其中涉及到更新了什么文件以及版本变更，出了问题可溯源。
<br/>代码发布管理：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/coderelease.png)
<br/>代码发布日志实时查看：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/coderelease_log.png)
<br/>执行记录：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/cod_excute_record.png)
<br/>更新日志查看（方便溯源）：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/coderelease_logdetail.png)
<br/><br/>


Zabbix数据报表管理面板：<br/>
<br/>输入zabbix报表生成三要素：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixInputInfo.png)
<br/>
<br/>上传无法调用zabbix接口获取的监控图像：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixReportUpload.png)
<br/>数据报表自动下载：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixReportDownload.png)
<br/>数据报表截图展示：<br/>
![image](https://github.com/420521738/itelftool/blob/master/screenshots/ZabbixReportExample.png)
<br/><br/>
