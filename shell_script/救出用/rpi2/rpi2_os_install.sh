#!/bin/bash

# 実行方法
# . install_ubuntu14.04_for_raspberry_pi_2.sh /dev/mmcblk0 ubuntu
# . install_ubuntu14.04_for_raspberry_pi_2.sh /dev/sdX rasbian

PMP="/dev/sdx"
PASS="ubuntu"

echo "what is your password:"
read PASS
if [ $# != 2 ]
then
	echo "書き込むSDカードのマウントポイントとosを引数に与えてください。$df -h で確認できます。5秒後に端末が閉じられるのですが ctrl-c で回避できます"
	sleep 5s
	exit 0
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
		echo "/dev/mmcblk0 または /dev/sdX のみ書いてください。$df -h で確認できます。5秒後に端末が閉じられるのですが ctrl-c で回避できます"
		sleep 5s
		exit 0
	fi
fi
echo $PASS | sudo -S apt-get update
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
if [ $2 = "ubuntu" ]
then
	echo $PASS | sudo -S apt-get -y install bmap-tools gddrescue
	DATA=(`ls *ubuntu-trusty.zip`)
	if [ ! `echo $DATA | grep 'ubuntu-trusty.zip'` ]
	then
		wget http://www.finnie.org/software/raspberrypi/2015-04-06-ubuntu-trusty.zip
	fi
	DATA=(`ls *ubuntu-trusty.img`)
	if [ ! `echo $DATA | grep 'ubuntu-trusty.img'` ]
	then
		unzip 2015-04-06-ubuntu-trusty.zip
		DATA=(`ls *ubuntu-trusty.img`)
	fi
	echo $PASS | sudo -S ddrescue -d -D --force ${DATA} ${1}
	DATA2=(`ls *ubuntu-trusty.bmap`)
	echo $PASS | sudo -S bmaptool copy --bmap ${DATA2} ${DATA} ${1}
	sync
fi
sudo fdisk ${1} <<\__EOF__
d
2
n
p
2
	

w
__EOF__
sudo e2fsck -f ${PMP2}
echo $PASS | sudo -S resize2fs ${PMP2}
mkdir ~/usb
echo $PASS | sudo -S mount ${PMP2} ~/usb
if [ $2 = "ubuntu" ]
then
	echo $PASS | sudo -S cp ~/rpi2/rpi_ubuntu_setup.sh ~/usb/home/ubuntu/rpi_ubuntu_setup.sh
	echo $PASS | sudo -S cp ~/rpi2/urgwidget_driver.tar.gz ~/usb/home/ubuntu/urgwidget_driver.tar.gz
	DATA=(`ls hidspx*`)
	echo $PASS | sudo -S cp ~/rpi2/$DATA ~/usb/home/ubuntu/$DATA
fi
echo $PASS | sudo -S umount ${PMP2}
rmdir ~/usb
echo "finish install os"

#参考サイト
#http://www.k4.dion.ne.jp/~mms/unix/shellscript/
#http://d.hatena.ne.jp/kitokitoki/20101009/p5
#http://www.redout.net/data/shellscript5.html
#https://wiki.ubuntu.com/ARM/RaspberryPi
#https://www.raspberrypi.org/documentation/installation/installing-images/linux.md
