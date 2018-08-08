客户端支持windows和Linux

windows下客户端：
	python环境
	pip install pywin32
	pip install wmi
	
Linux下客户端：
	python环境
	#chmod +x /MadKingClientRoot/plugins/linux/MegaCli
	需要安装megacli，ubuntu下的安装参考：https://www.iyunv.com/thread-311722-1-1.html
	
执行方法：
widows下：python C:\Users\Administrator\eclipse-workspace\MadKing\MadKingClient\bin\NedStark.py report_asset
linux 下：python /MadKingClient/bin/NedStark.py report_asset
注意：前提是创建好用户，并设置好该用户的token，并在客户端的settings文件中指明用户名和token,否则无法进行数据提交，会提示用户名或者token错误