#!/bin/bash

PASS="***"
ORD="camera,LRF,end point,error of eco,error of hyb,opened sh"
cd ~/youtube_uploader
DATA=(`ls *.ogv`)
for arg in ${DATA[@]}
do
	if [ `echo ${arg} | grep "ogv"` ]
	then
		echo ${arg}
		arg1=${arg%.*}
		FD=(`cat $arg1.csv`)
		if [ ! $FD ]
		then
			FD="no result data"
		fi
		echo $PASS | sudo -S python upload_video.py --file="${arg}" --title="${arg} movie" --description="${ORD}:\n${FD}" --keywords="recordmydesktop" --category="22" --privacyStatus="unlisted"
		RE=$?
		echo $RE
	fi
done
cd ~
