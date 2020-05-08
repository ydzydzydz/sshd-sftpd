#!/bin/bash

checkup_openssh (){
	rpm -qa | grep -q openssh-8.1 && release=8.1
	rpm -qa | grep -q openssh-5.3 && release=5.3
}

install_sftpd (){
	# 启动脚本：/etc/rc.d/init.d/sftpd
	cp src/script/sftpd /etc/rc.d/init.d/sftpd
	chmod +x /etc/rc.d/init.d/sftpd
	
	# 配置文件 /etc/ssh/sftpd_config
	cp $1  /etc/ssh/sftpd_config
	
	ln -sf  /usr/sbin/sshd  /usr/sbin/sftpd
	cp /etc/pam.d/sshd  /etc/pam.d/sftpd
	[ -f /etc/sysconfig/sshd ] && cp /etc/sysconfig/sshd  /etc/sysconfig/sftp
	cp /var/run/sshd.pid  /var/run/sftpd.pid && echo > /var/run/sftpd.pid
	
	# 禁用 SELinux
	# semanage port -a -t ssh_port_t -p tcp 2222
	# setenforce 0
	# sed -i "s/^SELINUX\=enforcing/SELINUX\=disabled/g" /etc/selinux/config
	
	# 防火墙放行端口
	# iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
	# iptables -A OUTPUT -p tcp --sport 2222 -j ACCEPT
	
	# 启动 sftpd
	service sftpd start
	
	# 设置开机自启
	chkconfig sftpd on
}

checkup_openssh

case $release in
"5.3")
	install_sftpd src/config/openssh5.3/sftpd_config
	;;
"8.1")
	install_sftpd src/config/openssh8.1/sftpd_config
	;;
*)
	echo -e "此脚本仅适用于 \033[31mOpenssh 5.3版本，8.1版本\033[0m"
	exit 1
esac
