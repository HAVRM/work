#!/bin/bash

PLACErpi2_os_install=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "raspberry2のosをインストールするプログラム.母艦で実行"
		echo ". rpi_os_install.sh (焼付け場所) (os名or圧縮ファイル名) ((焼付け方法))"
		echo "  焼付け場所   : /dev/sdd"
		echo "  os名        : ubuntu14,2-ubuntu16,3-ubuntu16,mate16,raspbian,noobs"
		echo "  圧縮ファイル名: *.img.zip"
		echo "  焼付け方法   : (unzip,xz)-(cp,dd,ddres,ddbmap) ->ex:xz-dd"
		return 0
	fi
fi
PMP="/dev/sdx"
PASS="***"
if [ $# != 2 -a $# != 3 ]
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
#echo $PASS | sudo -S apt-get -y install bmap-tools gddrescue xz-utils
#echo $PASS | sudo -S apt-get update | tr '\n' '\r'
#echo $PASS | sudo -S apt-get -y upgrade | tr '\n' '\r'
umount ${PMP}
umount ${PMP2}
sleep 5s
echo $PASS | sudo -S fdisk ${1} <<\__EOF__
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
DPF=$2
IMG=${DPF%.*}
DLP="NaN"
WCMD="NaN"
BMAP="NaN"
if [ $# = 3 ]
then
	WCMD=$3
fi

if [ $2 = "noobs" ]
then
	IMG="NOOBS_latest"
	DPF="NOOBS_latest"
	DLP="https://downloads.raspberrypi.org/NOOBS_latest"
	WCMD="unzip-cp"
elif [ $2 = "ubuntu14" ]
then
	IMG="ubuntu-trusty.img"
	BMAP="ubuntu-trusty.bmap"
	DPF="ubuntu-trusty.zip"
	DLP="http://www.finnie.org/software/raspberrypi/2015-04-06-ubuntu-trusty.zip"
	WCMD="unzip-ddbmap"
elif [ $2 = "2-ubuntu16" ]
then
	IMG="ubuntu-16.04-preinstalled-server-armhf+raspi2.img"
	DPF="ubuntu-16.04-preinstalled-server-armhf+raspi2.img.xz"
	DLP="http://cdimage.ubuntu.com/ubuntu/releases/16.04/release/ubuntu-16.04-preinstalled-server-armhf+raspi2.img.xz"
	WCMD="xz-dd"
elif [ $2 = "3-ubuntu16" ]
then
	IMG="ubuntu-16.04-preinstalled-server-armhf+raspi3.img"
	DPF="ubuntu-16.04-preinstalled-server-armhf+raspi3.img.xz"
	DLP="http://www.finnie.org/software/raspberrypi/ubuntu-rpi3/ubuntu-16.04-preinstalled-server-armhf+raspi3.img.xz"
	WCMD="xz-dd"
elif [ $2 = "mate16" ]
then
	IMG="ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img"
	DPF="ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img.xz"
	DLP="https://ubuntu-mate.org/raspberry-pi/ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img.xz"
	WCMD="xz-ddres"
elif [ $2 = "raspbian" ]
then
	IMG="raspbian_latest.img"
	DPF="raspbian_latest"
	DLP="https://downloads.raspberrypi.org/raspbian_latest"
	WCMD="unzip-dd"
fi

if [ ${WCMD} = "NaN" ]
then
	echo "set write type"
	return 0
fi
UPK=${WCMD%-*}
WSN=${WCMD#*-}
if [ -z ${UPK} -o -z ${WSN} ]
then
	echo "wrong write type"
	return 0
fi

DATA=`ls *${IMG}`
if [ -z ${DATA} ]
then
	DDATA=`ls *${DPF}`
	if [ $DLP = "NaN" -a -z ${DDATA} ]
	then
		echo "no img file"
		return 0
	fi
	if [ -z ${DDATA} ]
	then
		wget ${DLP}
		DDATA=`ls *${DPF}`
	fi
	if [ ${UPK} = "unzip" ]
	then
		if [ ${WSN} = "cp" ]
		then
			mkdir usb
			echo $PASS | sudo -S mount ${PMP} ${PLACErpi2_os_install}/usb
			echo $PASS | sudo -S cp ${DDATA} usb/${DDATA}
			cd usb
			echo $PASS | sudo -S unzip ${DDATA}
			echo $PASS | sudo -S rm -rf ${DDATA}
			cd ..
			echo $PASS | sudo -S umount ${PMP}
			rmdir usb
		else
			unzip ${DDATA}
		fi
	elif [ ${UPK} = "xz" ]
	then
		xz -dvk ${DLP}
	fi
	DATA=`ls *${IMG}`
fi

if [ ${WSN} = "dd" ]
then
	echo $PASS | sudo -S dd bs=4M if=${DATA} of=${1}
elif [ ${WSN} = "ddres" ]
then
	echo $PASS | sudo -S ddrescue -d -D --force ${DATA} ${1}
elif [ ${WSN} = "ddbmap" ]
then
	if [ -z ${BMAP} ]
	then
		echo "set bmap file"
		return 0
	fi
	echo $PASS | sudo -S ddrescue -d -D --force ${DATA} ${1}
	DATA2=(`ls *${BMAP}`)
	echo $PASS | sudo -S bmaptool copy --bmap ${DATA2} ${DATA} ${1}
fi
sync
if [ ${WSN} = "cp" ]
then
	echo "finish install os"
	return 0
fi
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
rm -rf ${DATA} ${DATA2}
echo "finish install os"
