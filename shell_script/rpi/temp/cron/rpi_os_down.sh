#!/bin/bash

PLACErpi_os_down=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "rpiのOSの圧縮ファイルを保持"
		echo ". rpi_os_down.sh"
		return 0
	fi
fi
#write progrum
DLP=(`cat ~/rpi2_u14_work/cron/rpi_os_adr.txt`)
cd ~/file/HDD/rpi_os
for arg in ${DLP[@]}
do
	wget -O ${arg%#*} ${arg#*#}
done
cd $PLACErpi_os_down
