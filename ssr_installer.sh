#!/bin/bash
#This is a shell script for deploy shadowsocks-R server.

sudo echo "y" | apt install expect
wget --no-check-certificate https://raw.githubusercontent.com/brucechenssfireinthehole/ssvpn/main/ssr.sh && chmod +x ssr.sh
expect -c "
spawn bash ./ssr.sh
expect \"请输入数字\" {send \"1\n\"}
expect \"端口\" {send \"2333\n\"}
expect \"密码\" {send \"123456\n\"}
expect \"加密方式\" {send \"1\n\"}
expect \"协议插件\" {send \"1\n\"}
expect \"混淆插件\" {send \"5\n\"}
expect \"混淆插件兼容原版\" {send \"y\n\"}
expect \"设备数限制\" {send \"\n\"}
expect \"单线程限速\" {send \"\n\"}
expect \"端口总限速\" {send \"\n\"}
interact
"
wget -N --no-check-certificate "https://raw.githubusercontent.com/brucechenssfireinthehole/ssvpn/main/tcp.sh"
chmod +x tcp.sh
sudo echo "4" | bash ./tcp.sh
