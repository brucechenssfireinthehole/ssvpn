#!/bin/bash
#This is a shell script for deploy shadowsocks server.

sudo echo "y" | yum install expect 

#1-create reboot scirpt
touch shadowsocks_installer_inner.sh
chmod 777 shadowsocks_installer_inner.sh
echo "#!/bin/bash
echo \"hello world\" > helloworld.txt
#install shadowsocks server
wget --no-check-certificate -O shadowsocks.sh https://raw.githubusercontent.com/brucechenssfireinthehole/ssvpn/main/shadowsocks.sh
chmod +x shadowsocks.sh

expect -c \"
spawn ./shadowsocks.sh
expect \"Please enter password for shadowsocks-python\" {send \"123456\n\"}
expect \"Please enter a port for shadowsocks-python\" {send \"6000\n\"}
expect \"Please select stream cipher for\" {send \"1\n\"}
expect \"Press any key to start\" {send \"\n\"}
expect eof
\"
" > shadowsocks_installer_inner.sh

touch shadowsocks_installer_inner.desktop 
chmod 777 shadowsocks_installer_inner.desktop
echo "[Desktop Entry]
Encoding=UTF-8
Exec=~/shadowsocks_installer_inner.sh
Type=Application
Name=shadowsocks_installer_inner" > shadowsocks_installer_inner.desktop 

sudo -cp -f shadowsocks_installer_inner.desktop /etc/xdg/autostart/

#2-install RuiSu speeder
wget -N  --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh
chmod +x serverspeeder-all.sh
expect -c "
spawn bash serverspeeder-all.sh
expect \"Do you want to restart system?\" {send \"y\n\"}
expect eof
"

