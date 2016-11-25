#!/bin/bash

PLACEshutdown_com=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "シャットダウン時に実行するプログラム"
		echo ". shutdown_com.sh"
		return 0
	fi
fi
#write progrum
cd /home/***
rm -rf sd_res.txt
. github_ctrl.sh 1>sd_res.txt 2>&1
cd rpi2_u14_work
. sub_git.sh >>/home/***/sd_res.txt 2>&1
cd $PLACEshutdown_com
