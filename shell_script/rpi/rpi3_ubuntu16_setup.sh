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
ADDRESS="192.168.1.150"
NETMASK="255.255.255.0"
NETWORK="192.168.1.0"
BROADCAST="192.168.1.255"
GATEWAY="192.168.1.1"

user_set()
{
echo "---user_set---"
cd ~
PLACE=`pwd`
PLACE=${PLACE##*/}
echo "your new password for ubuntu"
read UBUPASS
if [ ${PLACE} != ${USER} ]
then
	NUSER=`ls /home/ | grep ${USER}`
	if [ !${NUSER} ]
	then
		NUSER="ubuntu"
	fi
	if [ ${NUSER} != ${USER} ]
	then
		echo "${UBUPASS}" | sudo -S useradd -m ${USER}
		echo "${UBUPASS}" | sudo -S usermod -G sudo ${USER}
		echo "#!/bin/bash

echo \"${UBUPASS}\" | sudo -S passwd ${USER} <<\__EOF__
${PASS}
${PASS}
__EOF__" >.ru14su_sub.sh
		. .ru14su_sub.sh
		rm -rf .ru14su_sub.sh
	fi
	echo "${UBUPASS}" | sudo -S cp rpi_ubuntu14_setup.sh /home/${USER}/rpi_ubuntu14_setup.sh
	echo "#!/bin/bash

echo \"${UBUPASS}\" | sudo -S sh -c 'echo \"setterm -blank 0\" >>/home/${USER}/.bashrc'" >.ru14su_sub.sh
	. .ru14su_sub.sh
	rm -rf .ru14su_sub.sh
	echo "${UBUPASS}" | sudo -S -i -u ${USER} setterm -blank 0
	echo "${UBUPASS}" | sudo -S -i -u ${USER} . /home/${USER}/rpi_ubuntu14_setup.sh
	echo "#!/bin/bash

echo \". .rm_user_ru14su_sub.sh\" >>/home/${USER}/.bashrc
echo \"echo \\\"${PASS}\\\" | sudo -S userdel -r ubuntu
if [ \\\$? = 0 ]
then
	#rm -rf .rm_user_ru14su_sub.sh
	sed -i -e \\\"s/.\ .rm_user_ru14su_sub.sh//\\\" /home/${USER}/.bashrc
fi\" >/home/${USER}/.rm_user_ru14su_sub.sh" >/home/ubuntu/.ru14su_sub.sh
	echo "${UBUPASS}" | sudo -S -i -u ${USER} . /home/ubuntu/.ru14su_sub.sh
	rm -rf /home/ubuntu/.ru14su_sub.sh
	return 1
else
	if [ ${USER} = "ubuntu" -a ${PASS} != "ubuntu" ]
	then
		echo "#!/bin/bash

echo \"${UBUPASS}\" | sudo -S passwd ${USER} <<\__EOF__
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
cd ~
update_upgrade
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
mkdir rpi3_u16_work
cd ~/rpi3_u16_work
git init
git remote rm rpi3_u16_work
git remote add rpi3_u16_work https://${GITNAME}:${GITPASS}@github.com/HAVRM/rpi3_u16_work.git
git fetch rpi3_u16_work
git merge rpi3_u16_work/master
git config --global user.name "${GITNAME}"
git config --global user.email "${GITMAIL}"
}

PLACErpi_ubuntu14_setup=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "raspberry3(ubuntu16)のセットアップをするプログラム"
		echo ". rpi3_ubuntu16_setup"
		return 0
	fi
fi
#write progrum

user_set
if [ $? = 1 ]
then
	echo "${UBUPASS}" | sudo -S reboot now
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
echo ${PASS} | sudo -S sed -i -e "s/.\ \/home\/ubuntu\/rpi3_ubuntu16_setup.sh//" /home/ubuntu/.bashrc
cd $PLACErpi_ubuntu14_setup
