chgrp:改变文件所属用户组。命令格式为：chgrp 用户名 文件或目录。
chown:改变文件所有者。命令格式为：chown 所有者 文件或目录。
chmod:改变文件的权限。命令格式为：chmod 权限属性 文件或目录。
        chmod 777 test
        chmod -R 775 test

# sudo su   # switch to root

# ps
	ps -le | grep 'php-fpm'   	先查找出php-fpm的进程号
	ps -ef | grep nginx     # show nginx process
	kill -QUIT 30536        	# kill process

# nginx
	nginx's config-file in (/etc/nginx/sites-available/default)
	service nginx start
	sudo service nginx reload
	service nginx status    # active(runing) is ok



# query port
	netstat -tnlp


# delete folders
	rm -rf 目录名字

# rename folder
	mv A B

# git
	git pull 获取新版本
	git status
	git add .
	git commit -m "add new files"
	git remote add origin git@github.com:FranFan/php-demo
	git push -u origin master 
	git rm --cached filename		将它们从索引中删除


# apt-get
	sudo apt list xxxx*
	apt-cache search package 搜索包
	apt-cache show package 获取包的相关信息，如说明、大小、版本等
	sudo apt-get install package 安装包
	sudo apt-get install package - - reinstall 重新安装包
	sudo apt-get -f install 修复安装"-f = ——fix-missing"
	sudo apt-get remove package 删除包
	sudo apt-get remove package - - purge 删除包，包括删除配置文件等
	sudo apt-get update 更新源
	sudo apt-get upgrade 更新已安装的包
	sudo apt-get dist-upgrade 升级系统
	sudo apt-get dselect-upgrade 使用 dselect 升级
	apt-cache depends package 了解使用依赖
	apt-cache rdepends package 是查看该包被哪些包依赖
	sudo apt-get build-dep package 安装相关的编译环境
	apt-get source package 下载该包的源代码
	sudo apt-get clean && sudo apt-get autoclean 清理无用的包
	sudo apt-get check 检查是否有损坏的依赖

# dpkg
	dpkg -l | grep ***	
	dpkg-query -L php5-dev 来查看这个包里面包含哪些文件	

# 关机命令
	1、reboot 
	2、shutdown -r now 立刻重启(root用户使用) 
	3、shutdown -r 10 过10分钟自动重启(root用户使用) 
	4、shutdown -r 20:35 在时间为20:35时候重启(root用户使用) 
	5、shutdown -c 命令取消重启 
	1、halt   立刻关机 
	2、poweroff 立刻关机 
	3、shutdown -h now 立刻关机(root用户使用) 
	4、shutdown -h 10 10分钟后自动关机 

# php
	php -i | grep php.ini 			// find where php.ini
	php -m		// install what modules
	php -ini

# telnet
	telnet 127.0.0.1 9501

# netstat
	netstat -an | grep 端口，查看端口是否已经被打开处于Listening状态
