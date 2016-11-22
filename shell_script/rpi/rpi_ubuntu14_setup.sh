#!/bin/bash

USER="ubuntu"
PASS="ubuntu"
GITNAME="HAVRM"
GITMAIL="***@gmail.com"
GITPASS="***"
SSID="***"
WPA2="***"
DSKP="gnome" #"gnome","lubuntu","xubuntu","kubuntu"

user_set()
{
echo "---user_set---"
cd ~
PLACE=`pwd`
PLACE=${PLACE##*/}
if [ ${PLACE} != ${USER} ]
then
	if [ `ls /home/ | grep ${USER}` != ${USER} ]
	then
		echo "ubuntu" | sudo -S useradd -m ${USER}
		echo "#!/bin/bash

echo \"ubuntu\" | sudo -S passwd ${USER} <<\__EOF__
${PASS}
${PASS}
__EOF__" >.ru14su_sub.sh
		. .ru14su_sub.sh
		rm -rf .ru14su_sub.sh
	fi
	echo "ubuntu" | sudo -S cp rpi_ubuntu14_setup.sh /home/${USER}/rpi_ubuntu14_setup.sh
	echo "ubuntu" | sudo -S -i -u ${USER} . /home/${USER}/rpi_ubuntu14_setup.sh
	echo "#!/bin/bash

echo \". .rm_user_ru14su_sub.sh\" >>/home/${USER}/.bashrc
echo \"echo \\\"${PASS}\\\" | sudo -S userdel -r ubuntu
if [ \\\$? = 0 ]
then
	rm -rf .rm_user_ru14su_sub.sh
	sed -i -e \\\"s/.\ .rm_user_ru14su_sub.sh//\\\" /home/${USER}/.bashrc\" >>/home/${USER}/.rm_user_ru14su_sub.sh" >.ru14su_sub.sh
	echo "ubuntu" | sudo -S -i -u ${USER} . .ru14su_sub.sh
	rm -rf .ru14su_sub.sh
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
DATA=(`ping 8.8.8.8 -c 5 | grep "64 bytes from 8.8.8.8"`)
if [ ! ${DATA} ]
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
echo $PASS | sudo -S apt-get update 1>/dev/null 2>&1
echo $PASS | sudo -S apt-get -y upgrade 1>/dev/null 2>&1
}

base_install()
{
echo "---base_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install dphys-swapfile linux-firmware openssh-server ssh wireless-tools
cd ~
}

wireless_setup()
{
echo "---wireless_setup---"
cd ~
update_upgrade
echo $PASS | sudo -S echo "
#The wireless interface
auto wlan0
iface wlan0 inet dhcp
wpa-ssid ${SSID}
wpa-ap-scan 1
wpa-key-mgmt WPA-PSK
wpa-psk ${WPA2}" >>/etc/network/interfaces
cd ~
}

japanese_setup()
{
echo "---japanese_setup---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install xserver-xorg-video-fbturbo fonts-takao language-pack-ja language-pack-gnome-ja ibus-mozc
echo $PASS | sudo -S echo "Section \"Device\"
	Identifier \"Raspberry Pi FBDEV\"
	Driver \"fbturbo\"
	Option \"fbdev\" \"/dev/fb0\"
	Option \"SwapbuffersWait\" \"true\"
EndSection" >>/etc/X11/xorg.conf
echo "Asia/Tokyo" | sudo tee /etc/timezone
echo $PASS | sudo -S dpkg-reconfigure -f noninteractive tzdata
echo $PASS | sudo -S locale-gen ja_JP.UTF-8
echo $PASS | sudo -S dpkg-reconfigure -f noninteractive locales
echo $PASS | sudo -S echo "LANG=\"ja_JP.UTF-8\"" >>/etc/default/locale
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
echo $PASS | sudo -S apt-get -y install emacs24
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
. ~/rm_~_file.sh
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
	echo ${PASS} | sudo -S reboot now
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
update_upgrade
cd $PLACErpi_ubuntu14_setup