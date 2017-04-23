#!/bin/bash

USER="***"
PASS="***"
GITNAME="HAVRM"
GITMAIL="***@gmail.com"
GITPASS="***"
SSID="***"
WPA2="***"
DSKP="gnome" #"gnome","lubuntu","xubuntu","kubuntu" can be select
WIRELESS_ONLY="true" #"true" or "false", if "true" then you CANNOT use ethernet
WIRELESS_IP="static" #"static" or "dhcp"
WIFIMODULE="WN-G150UM"
OATK="***"
ADDRESS="192.168.3.150"
NETMASK="255.255.255.0"
NETWORK="192.168.3.0"
BROADCAST="192.168.3.255"
GATEWAY="192.168.3.1"

user_set()
{
echo "---user_set---"
cd ~
PLACE=`pwd`
PLACE=${PLACE##*/}
if [ ${PLACE} != ${USER} ]
then
	NUSER=`ls /home/ | grep ${USER}`
	if [ !${NUSER} ]
	then
		NUSER="ubuntu"
	fi
	if [ ${NUSER} != ${USER} ]
	then
		echo "ubuntu" | sudo -S useradd -m ${USER}
		echo "ubuntu" | sudo -S usermod -G sudo ${USER}
		echo "#!/bin/bash

echo \"ubuntu\" | sudo -S passwd ${USER} <<\__EOF__
${PASS}
${PASS}
__EOF__" >.ru14su_sub.sh
		. .ru14su_sub.sh
		rm -rf .ru14su_sub.sh
	fi
	echo "ubuntu" | sudo -S cp rpi_ubuntu14_setup.sh /home/${USER}/rpi_ubuntu14_setup.sh
	echo "#!/bin/bash

echo \"ubuntu\" | sudo -S sh -c 'echo \"setterm -blank 0\" >>/home/${USER}/.bashrc'" >.ru14su_sub.sh
	. .ru14su_sub.sh
	rm -rf .ru14su_sub.sh
	echo "ubuntu" | sudo -S -i -u ${USER} setterm -blank 0
	echo "ubuntu" | sudo -S -i -u ${USER} . /home/${USER}/rpi_ubuntu14_setup.sh
	echo "#!/bin/bash

echo \". .rm_user_ru14su_sub.sh\" >>/home/${USER}/.bashrc
echo \"echo \\\"${PASS}\\\" | sudo -S userdel -r ubuntu
if [ \\\$? = 0 ]
then
	#rm -rf .rm_user_ru14su_sub.sh
	sed -i -e \\\"s/.\ .rm_user_ru14su_sub.sh//\\\" /home/${USER}/.bashrc
fi\" >/home/${USER}/.rm_user_ru14su_sub.sh" >/home/ubuntu/.ru14su_sub.sh
	echo "ubuntu" | sudo -S -i -u ${USER} . /home/ubuntu/.ru14su_sub.sh
	rm -rf /home/ubuntu/.ru14su_sub.sh
	return 1
else
	if [ ${USER} = "ubuntu" -a ${PASS} != "ubuntu" ]
	then
		echo "#!/bin/bash

echo \"ubuntu\" | sudo -S passwd ${USER} <<\__EOF__
ubuntu
${PASS}
${PASS}
__EOF__" >.ru14su_sub.sh
		. .ru14su_sub.sh
		rm -rf .ru14su_sub.sh
	fi
	return 0
fi
}

net_check()
{
echo "---net_check---"
ping 8.8.8.8 -c 5 | grep -q "icmp_seq=1"
if [ $? = 1 ]
then
	echo "this machine is not in the internet"
	return -1
else
	return 0
fi
}

update_upgrade()
{
echo "---update_upgrade---"
echo $PASS | sudo -S apt-get update | tr '\n' '\r'
echo ""
echo $PASS | sudo -S apt-get -y upgrade | tr '\n' '\r'
}

base_install()
{
echo "---base_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install dphys-swapfile linux-firmware openssh-server ssh
cd ~
}

wireless_setup()
{
echo "---wireless_setup---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install wireless-tools wpasupplicant
if [ $WIFIMODULE = "WN-G150UM" ]
then
	echo $PASS | sudo -S sh -c 'echo "ACTION==\"add\", SUBSYSTEM==\"usb\", ATTR{idVendor}==\"04bb\", ATTR{idProduct}==\"094c\", RUN+=\"/sbin/modprobe -qba 8192cu\"" >>/etc/udev/rules.d/network_drivers.rules'
	echo $PASS | sudo -S sh -c 'echo "install 8192cu /sbin/modprobe --ignore-install 8192cu $CMDLINE_OPTS; /bin/echo \"04bb 094c\" > /sys/bus/usb/drivers/rtl8192cu/new_id" >>/etc/modprobe.d/network_drivers.conf'
fi
echo $PASS | sudo -S ifconfig wlan0 up
echo $PASS | sudo -S sh -c "sudo wpa_passphrase ${SSID} ${WPA2} >>/etc/wpa_supplicant/wpa_supplicant.conf"
if [ ${WIRELESS_ONLY} = "true" ]
then
	echo $PASS | sudo -S sed -i -e "s/eth0/wlan0/" /etc/network/interfaces
elif [ ${WIRELESS_ONLY} = "false" ]
then
	echo $PASS | sudo -S sh -c 'echo "
allow-hotplug wlan0" >>/etc/network/interfaces'
fi
if [ ${WIRELESS_IP} = "static" ]
then
	if [ ${WIRELESS_ONLY} = "true" ]
	then
		echo $PASS | sudo -S sed -i -e "s/dhcp/static/" /etc/network/interfaces
	elif [ ${WIRELESS_ONLY} = "false" ]
	then
		echo $PASS | sudo -S sh -c 'echo "
iface wlan0 inet dhcp" >>/etc/network/interfaces'
	fi
	echo "#!/bin/bash

echo $PASS | sudo -S sh -c 'echo \"
address ${ADDRESS}
netmask ${NETMASK}
network ${NETWORK}
broadcast ${BROADCAST}
gateway ${GATEWAY}
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf\" >>/etc/network/interfaces'" >/home/${USER}/.rpi2_u14_setup_sub.sh
	. /home/${USER}/.rpi2_u14_setup_sub.sh
	rm -rf /home/${USER}/.rpi2_u14_setup_sub.sh
	echo "#!/bin/bash

echo $PASS | sudo -S sh -c 'echo \"nameserver ${GATEWAY}\" >>/etc/resolvconf/resolv.conf.d/base'" >/home/${USER}/.rpi2_u14_setup_sub.sh
	. /home/${USER}/.rpi2_u14_setup_sub.sh
	rm -rf /home/${USER}/.rpi2_u14_setup_sub.sh
elif [ ${WIRELESS_IP} = "static" ]
then
	echo $PASS | sudo -S sh -c 'echo "
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" >>/etc/network/interfaces'
fi
cd ~
}

japanese_setup()
{
echo "---japanese_setup---"
#cd ~
#update_upgrade
#echo $PASS | sudo -S apt-get -y install language-pack-ja manpages-ja
#echo $PASS | sudo -S update-locale LANG=ja_JP.UTF-8
#export LANG=ja_JP.UTF-8
#echo "case \$TERM in
#     linux)LANG=C ;;
#     *)LANG=ja_JP.UTF-8 ;;
#esac" >>/home/${USER}/.bashrc
#LANG=C
echo "Asia/Tokyo" | sudo tee /etc/timezone
echo $PASS | sudo -S dpkg-reconfigure -f noninteractive tzdata
echo $PASS | sudo -S sed -i -e "s/\"us\"/\"jp\"/" /etc/default/keyboard
echo $PASS | sudo -S dpkg-reconfigure -f noninteractive keyboard-configuration
cd ~
}

desktop_install()
{
echo "---desktop_install---"
cd ~
update_upgrade
if [ $DSKP = "gnome" ]
then
	echo "----gnome----"
	echo $PASS | sudo -S apt-get -y install ubuntu-desktop gnome-session-flashback
elif [ $DSKP = "lubuntu" ]
then
	echo "----lubuntu----"
	echo $PASS | sudo -S apt-get -y install lubuntu-desktop
elif [ $DSKP = "xubuntu" ]
then
	echo "----xubuntu----"
	echo $PASS | sudo -S apt-get -y install xubuntu-desktop
elif [ $DSKP = "kubuntu" ]
then
	echo "----kubuntu----"
	echo $PASS | sudo -S apt-get -y install kubuntu-desktop
fi
cd ~
}

web_server_install()
{
echo "---web_server_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install apache2
echo ${PASS} | sudo -S sed -i -e "s/Options Indexes FollowSymLinks/Options Indexes FollowSymLinks ExecCGI\r\tAddHandler cgi-script .cgi/g" /etc/apache2/apache2.conf
cd /etc/apache2/mods-enabled
echo ${PASS} | sudo -S ln -s ../mods-available/cgi.load .
echo ${PASS} | sudo -S /usr/sbin/apachectl restart
cd ~
}

file_server_install()
{
echo "---file_server_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install samba
echo $PASS | sudo -S smbpasswd -a ${PASS}
#https://piro.sakura.ne.jp/latest/blosxom/system/2015-07-04_raspberrypi-nas.htm
cd ~
}

other_install()
{
echo "---other_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install emacs24 imagemagick unrar pdftk screen git calibre expect curl
cd ~
}

shell_install()
{
echo "---shell_install---"
cd ~
update_upgrade
rm -rf rm_~_file.sh update_upgrade.sh 1>/dev/null 2>&1
wget https://raw.githubusercontent.com/HAVRM/work/master/shell_script/home/rm_~_file.sh
wget https://raw.githubusercontent.com/HAVRM/work/master/shell_script/home/update_upgrade.sh
sed -i -e "s/\*\*\*/${PASS}/" ~/update_upgrade.sh
sed -i -e "s/\/windows/~/" ~/rm_~_file.sh
. ~/rm_~_file.sh
cd ~
}

git_setup()
{
echo "---github_setup---"
cd ~
update_upgrade
mkdir rpi2_u14_work
cd ~/rpi2_u14_work
git init
git remote rm rpi2_u14_work
git remote add rpi2_u14_work https://${GITNAME}:${GITPASS}@github.com/HAVRM/rpi2_u14_work.git
git fetch rpi2_u14_work
git merge rpi2_u14_work/master
git config --global user.name "${GITNAME}"
git config --global user.email "${GITMAIL}"
echo ${PASS} | sudo -S rm -rf /var/www/*
echo ${PASS} | sudo -S ln -s ~/rpi2_u14_work/html /var/www/
mkdir ~/file
chmod a+w ~/file
echo ${PASS} | sudo -S ln -s ~/file ~/rpi2_u14_work/html
cp -rf auto_pdf ~/auto_pdf
sed -i -e "s/ubuntu/${USER}/" /home/${USER}/auto_pdf/auto_get_pdf.sh
echo $PASS | sudo -S sh -c "echo OAUTH_ACCESS_TOKEN=${OATK} >/home/${USER}/auto_pdf/.dropbox_uploader"
echo "#!/bin/bash

echo $PASS | sudo -S sh -c 'echo \"0 0,6,12,18 * * * /bin/bash /home/${USER}/auto_pdf/auto_get_pdf.sh >/home/${USER}/cron_log/agp 2>&1
0 1 * * * /bin/bash /home/${USER}/update_upgrade.sh >/home/${USER}/cron_log/uu 2>&1
\" >>/var/spool/cron/crontabs/${USER}'" >/home/${USER}/.rpi2_u14_setup_sub.sh
. /home/${USER}/.rpi2_u14_setup_sub.sh
rm -rf /home/${USER}/.rpi2_u14_setup_sub.sh
echo $PASS | sudo -s chown ${USER}:crontab /var/spool/cron/crontabs/${USER}
mkdir ~/cron_log
chmod a+x /home/${USER}/auto_pdf/auto_get_pdf.sh
chmod a+x /home/${USER}/update_upgrade.sh
cd ~
}

PLACErpi_ubuntu14_setup=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "raspberry2(ubuntu14)のセットアップをするプログラム"
		echo ". rpi_ubuntu14_setup"
		return 0
	fi
fi
#write progrum

user_set
if [ $? = 1 ]
then
	echo "ubuntu" | sudo -S reboot now
	return 0
fi
net_check
if [ $? = -1 ]
then
	return 0
fi
update_upgrade
base_install
wireless_setup
japanese_setup
desktop_install
web_server_install
#file_server_install
other_install
shell_install
git_setup
update_upgrade
cd ~
echo ${PASS} | sudo -S sed -i -e "s/.\ \/home\/ubuntu\/rpi_ubuntu14_setup.sh//" /home/ubuntu/.bashrc
cd $PLACErpi_ubuntu14_setup
