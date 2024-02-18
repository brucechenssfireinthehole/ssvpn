#!/bin/bash
#This is a shell script for deploy shadowsocks server.

sudo echo "y" | yum install expect

#1-create reboot scirpt
touch shadowsocks_installer_inner.sh
chmod 777 shadowsocks_installer_inner.sh
echo "#!/bin/bash
cd ~
echo \"hello world\" > helloworld.txt
#install shadowsocks server
wget --no-check-certificate -O shadowsocks.sh https://raw.githubusercontent.com/brucechenssfireinthehole/ssvpn/main/shadowsocks.sh
chmod +x shadowsocks.sh

expect -c \"
spawn ./shadowsocks.sh
expect \\\"Please enter password for shadowsocks-python\\\" {send \\\"123456\n\\\"}
expect \\\"Please enter a port for shadowsocks-python\\\" {send \\\"6000\n\\\"}
expect \\\"Please select stream cipher for\\\" {send \\\"1\n\\\"}
expect \\\"Press any key to start\\\" {send \\\"\n\\\"}
interact
\"
" > shadowsocks_installer_inner.sh
#sudo cp -f shadowsocks_installer_inner.sh /usr/bin/

# touch shadowsocks_installer_inner.desktop
# chmod 777 shadowsocks_installer_inner.desktop
# echo "[Desktop Entry]
# Encoding=UTF-8
# Exec=/usr/bin/shadowsocks_installer_inner.sh
# Type=Application
# Name=shadowsocks_installer_inner" > shadowsocks_installer_inner.desktop

# sudo cp -f shadowsocks_installer_inner.desktop /etc/xdg/autostart/

touch /etc/systemd/system/rc-local.service
chmod 777 /etc/systemd/system/rc-local.service
echo "[Install]
WantedBy=multi-user.target
Alias=rc-local.service
" > /etc/systemd/system/rc-local.service

touch /etc/rc.local
chmod 777 /etc/rc.local
echo "#!/bin/bash
chmod +x ~/shadowsocks_installer_inner.sh
~/shadowsocks_installer_inner.sh
" > /etc/rc.local

sudo systemctl start rc-local

#2-install bbr speeder
wget --no-check-certificate https://raw.githubusercontent.com/brucechenssfireinthehole/ssvpn/main/bbr.sh && chmod +x bbr.sh
expect -c "
spawn ./bbr.sh
expect \"Press any key to start\" {send \"\n\"}
interact
"
expect -c "
spawn echo \"wait for system reboot\"
expect \"Do you want to restart system\" {send \"y\n\"}
interact
"
# reboot
# ./bbr.sh
# sleep 60
# reboot
