#!/bin/bash

PLACErpi2_os_install=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "raspberry2のosをインストールするプログラム.母艦で実行"
		echo ". rpi_os_install.sh (焼付け場所:/dev/sdd) (os名:ubuntu14,2-ubuntu16,3-ubuntu16,mate16,raspbian,noobs)"
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
echo $PASS | sudo -S apt-get update | tr '\n' '\r'
echo $PASS | sudo -S apt-get -y upgrade | tr '\n' '\r'
echo $PASS | sudo -S apt-get -y install bmap-tools gddrescue xz-utils
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
elif [ $2 = "ubuntu14" ]
then
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
	sudo e2fsck -f ${PMP2}
	#do not use 'echo $PASS | sudo -S' when e2fsck
	echo $PASS | sudo -S resize2fs ${PMP2}
	if [ `ls rpi_ubuntu14_setup.sh` ]
	then
		mkdir ~/usb
		echo $PASS | sudo -S mount ${PMP2} ~/usb
		echo $PASS | sudo -S cp rpi_ubuntu14_setup.sh ~/usb/home/ubuntu/rpi_ubuntu14_setup.sh
		echo $PASS | sudo -S mkdir -p ~/usb/home/ubuntu/rpi
		echo $PASS | sudo -S chmod a+w ~/usb/home/ubuntu/rpi/
		cp ${PLACErpi2_os_install}/*.sh ~/usb/home/ubuntu/rpi/
		echo $PASS | sudo -S sh -c 'echo ". /home/ubuntu/rpi_ubuntu14_setup.sh" >>~/usb/home/ubuntu/.bashrc'
		echo $PASS | sudo -S sh -c 'echo "setterm -blank 0" >>~/usb/home/ubuntu/.bashrc'
		echo $PASS | sudo -S sh -c 'echo "autologin-user=ubuntu
autologin-user-timeout=0" >>~/usb/etc/lightdm/lightdm.conf'
		echo $PASS | sudo -S umount ${PMP2}
		rmdir ~/usb
	fi
elif [ $2 = "2-ubuntu16" ]
then
	DATA=(`ls *rpi2-ubuntu16.img`)
	if [ ! `echo $DATA | grep 'rpi2-ubuntu16.img'` ]
	then
		DATA=(`ls *rpi2-ubuntu16.img.xz`)
		if [ ! `echo $DATA | grep 'rpi2-ubuntu16.img.xz'` ]
		then
			wget -O rpi2-ubuntu16.img.xz http://cdimage.ubuntu.com/ubuntu/releases/16.04/release/ubuntu-16.04-preinstalled-server-armhf+raspi2.img.xz
		fi
		xz -dvk rpi2-ubuntu16.img.xz
		DATA=(`ls *rpi2-ubuntu16.img`)
	fi
	echo $PASS | sudo -S dd bs=4M if=${DATA} of=${1}
	sync
elif [ $2 = "3-ubuntu16" ]
then
	DATA=(`ls *rpi3-ubuntu16.img`)
	if [ ! `echo $DATA | grep 'rpi3-ubuntu16.img'` ]
	then
		DATA=(`ls *rpi3-ubuntu16.img.xz`)
		if [ ! `echo $DATA | grep 'rpi3-ubuntu16.img.xz'` ]
		then
			wget -O rpi3-ubuntu16.img.xz http://www.finnie.org/software/raspberrypi/ubuntu-rpi3/ubuntu-16.04-preinstalled-server-armhf+raspi3.img.xz
		fi
		xz -dvk rpi3-ubuntu16.img.xz
		DATA=(`ls *rpi3-ubuntu16.img`)
	fi
	echo $PASS | sudo -S dd bs=4M if=${DATA} of=${1}
	sync
	PSSTA=(`echo ${PASS} | sudo -S fdisk -l ${1}`)
	POINT=0
	for arg in ${PSSTA[@]}
	do
		if [ ${POINT} = 1 ]
		then
			break
		elif [ ${arg} = "${PMP2}" ]
		then
			POINT=1
		fi
	done
	echo "#!/bin/bash

echo $PASS | sudo -S fdisk ${1} <<\__EOF__
d
2
n
p
2
${arg}

w
__EOF__" >.rpi_os_install_sub.sh
	. .rpi_os_install_sub.sh
	rm -f .rpi_os_install_sub.sh
	sudo e2fsck -f ${PMP2}
	#do not use 'echo $PASS | sudo -S' when e2fsck
	echo $PASS | sudo -S resize2fs ${PMP2}
	if [ `ls rpi3_ubuntu16_setup.sh` ]
	#if [ "0" = "1" ]
	then
		mkdir ~/usb
		echo $PASS | sudo -S mount ${PMP2} ~/usb
		echo $PASS | sudo -S mkdir -p ~/usb/home/ubuntu/rpi
		echo $PASS | sudo -S cp rpi3_ubuntu16_setup.sh ~/usb/home/ubuntu/rpi3_ubuntu16_setup.sh
		echo $PASS | sudo -S chmod a+x ~/usb/home/ubuntu/rpi3_ubuntu16_setup.sh
		echo $PASS | sudo -S chmod a+w ~/usb/home/ubuntu/rpi/
		cp ${PLACErpi2_os_install}/*.sh ~/usb/home/ubuntu/rpi/
		echo $PASS | sudo -S sed -i -e "s/exit\ 0/.\ \/home\/ubuntu\/rpi3_ubuntu16_setup.sh\nexit\ 0/" /etc/rc.local
		#echo $PASS | sudo -S sh -c 'echo "setterm -blank 0" >>~/usb/home/ubuntu/.bashrc'
		echo $PASS | sudo -S umount ${PMP2}
		rmdir ~/usb
	fi
elif [ $2 = "mate16" ]
then
	DATA=(`ls *rpi-ubuntumate16.img`)
	if [ ! `echo $DATA | grep 'rpi-ubuntumate16.img'` ]
	then
		DATA=(`ls *rpi-ubuntumate16.img.xz`)
		if [ ! `echo $DATA | grep 'rpi-ubuntumate16.img.xz'` ]
		then
			wget -O rpi-ubuntumate16.img.xz https://ubuntu-mate.org/raspberry-pi/ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img.xz
		fi
		unxz rpi-ubuntumate16.img.xz
		DATA=(`ls *rpi-ubuntumate16.img`)
	fi
	echo $PASS | sudo -S ddrescue -D --force ${DATA} ${1}
	sync
	echo $PASS | sudo -S fdisk ${1} <<\__EOF__
d
2
n
p
2
	

w
__EOF__
	sudo e2fsck -f ${PMP2}
	#do not use 'echo $PASS | sudo -S' when e2fsck
	echo $PASS | sudo -S resize2fs ${PMP2}
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
