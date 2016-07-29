#!/bin/bash

PLACErpi2_os_install=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "raspberry2のosをインストールするプログラム.母艦で実行"
		echo ". rpi2_os_install.sh (焼付け場所:/dev/sdd) (os名:ubuntu,raspbian,noobs)"
		return 0
	fi
fi
PMP="/dev/sdx"
PASS="***"
if [ $# != 2 ]
then
	echo "書き込むSDカードのマウントポイントとosを引数に与えてください。"
	return 0
else
	if [ $1 = "/dev/mmcblk0" ]
	then
		PMP="${1}p1"
		PMP2="${1}p2"
	elif [ `echo $1 | grep '/dev/sd'` -a ${#1} = ${#PMP} ]
	then
		PMP="${1}1"
		PMP2="${1}2"
	else
		echo "/dev/mmcblk0 または /dev/sdX のみ書いてください。"
		return 0
	fi
fi
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y upgrade
umount ${PMP}
umount ${PMP2}
sleep 5s
sudo fdisk ${1} <<\__EOF__
d
1
d
2
n
p
1
	

w
__EOF__
echo $PASS | sudo -S mkfs.vfat -F 32 ${PMP}

#使うパッケージのインストール
if [ $2 = "noobs" ]
then
	mkdir usb
	echo $PASS | sudo -S mount ${PMP} ${PLACErpi2_os_install}/usb
	DATA=(`ls NOOBS_latest`)
	if [ ! `echo $DATA | grep 'NOOBS_latest'` ]
	then
		wget https://downloads.raspberrypi.org/NOOBS_latest
	fi
	echo $PASS | sudo -S cp NOOBS_latest usb/NOOBS_latest
	cd usb
	echo $PASS | sudo -S unzip NOOBS_latest
	echo $PASS | sudo -S rm -rf NOOBS_latest
	cd ..
	echo $PASS | sudo -S umount ${PMP}
	rmdir usb
elif [ $2 = "ubuntu" ]
then
	echo $PASS | sudo -S apt-get -y install bmap-tools gddrescue
	DATA=(`ls *ubuntu-trusty.img`)
	if [ ! `echo $DATA | grep 'ubuntu-trusty.img'` ]
	then
		DATA=(`ls *ubuntu-trusty.zip`)
		if [ ! `echo $DATA | grep 'ubuntu-trusty.zip'` ]
		then
			wget http://www.finnie.org/software/raspberrypi/2015-04-06-ubuntu-trusty.zip
		fi
		unzip 2015-04-06-ubuntu-trusty.zip
		DATA=(`ls *ubuntu-trusty.img`)
	fi
	echo $PASS | sudo -S ddrescue -d -D --force ${DATA} ${1}
	DATA2=(`ls *ubuntu-trusty.bmap`)
	echo $PASS | sudo -S bmaptool copy --bmap ${DATA2} ${DATA} ${1}
	sync
	echo $PASS | sudo -S fdisk ${1} <<\__EOF__
d
2
n
p
2
	

w
__EOF__
	echo $PASS | sudo -S e2fsck -f ${PMP2}
	echo $PASS | sudo -S resize2fs ${PMP2}
	mkdir ~/usb
	echo $PASS | sudo -S mount ${PMP2} ~/usb
	echo $PASS | sudo -S cp ~/rpi2/rpi_ubuntu_setup.sh ~/usb/home/ubuntu/rpi_ubuntu_setup.sh
	echo $PASS | sudo -S cp ~/rpi2/urgwidget_driver.tar.gz ~/usb/home/ubuntu/urgwidget_driver.tar.gz
	DATA=(`ls hidspx*`)
	echo $PASS | sudo -S cp ~/rpi2/$DATA ~/usb/home/ubuntu/$DATA
	echo $PASS | sudo -S umount ${PMP2}
	rmdir ~/usb
elif [ $2 = "raspbian" ]
then
	DATA=(`ls *raspbian-jessie.img`)
	if [ ! `echo $DATA | grep 'raspbian-jessie.img'` ]
	then
		DATA=(`ls raspbian_latest`)
		if [ ! `echo $DATA | grep 'raspbian_latest'` ]
		then
			wget https://downloads.raspberrypi.org/raspbian_latest
		fi
		unzip raspbian_latest
		DATA=(`ls *raspbian-jessie.img`)
	fi
	echo $PASS | sudo -S dd bs=4M if=${DATA} of=${1}
	sync
fi
echo "finish install os"
