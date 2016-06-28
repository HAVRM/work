#!/bin/bash

#cd ~/catkin_ws/src/Robocon_2016/shell_script
#. end_ros.sh
cd ~
PRE_IFS=$IFS
IFS=$'\n'
PASS="***"
ORD="camera,LRF,end point,error of eco,error of hyb,opened sh"
cd ~/mylog
if [ $# = 0 ]
then
	DAY=`date '+%m%d'`
else
	DAY=$1
fi
echo $DAY
DATA=(`ls`)
mkdir -p /windows/mylog/${DAY}
echo "time,camera,LRF,end point,error of eco,error of hyb,opened sh,url" >> /windows/mylog/${DAY}/${DAY}.csv
for arg in ${DATA[@]}
do
	if [ `echo ${arg} | grep ${DAY}` ]
	then
		echo ${arg}
		cd ${arg}
		CSV=`ls ${arg}.csv`
		if [ ${CSV} ]
		then
			RES=`cat ${arg}.csv`
		else
			RES="-,-,-,-,-,-"
		fi
		FD=(`ls *.ogv`)
		if [ `echo ${FD} | grep "out.ogv"` ]
		then
			mv out.ogv ~/youtube_uploader/${arg}.ogv
			cd ~/youtube_uploader
			URL=(`echo $PASS | sudo -S python upload_video.py --file="${arg}.ogv" --title="${arg} movie" --description="${ORD} : ${RES}" --keywords="recordmydesktop" --category="22" --privacyStatus="unlisted"`)
			if [ ${#URL} = 11 ]
			then
				echo "${arg},${RES},https://youtu.be/${URL}" >> /windows/mylog/${DAY}/${DAY}.csv
				mv ${arg}.ogv send/${arg}.ogv
			else
				echo "${arg},${RES},error : ${URL}" >> /windows/mylog/${DAY}/${DAY}.csv
				mv ${arg}.ogv error/${arg}.ogv
			fi
			cd ~/mylog/${arg}
		else
			echo "${arg},${RES},-" >> /windows/mylog/${DAY}/${DAY}.csv
		fi
		cd ..
		mv ${arg} /windows/mylog/${DAY}/${arg} 2> /dev/null
	fi
done
cd ~
IFS=$PRE_IFS
. update_upgrade.sh
. rm_~_file.sh
