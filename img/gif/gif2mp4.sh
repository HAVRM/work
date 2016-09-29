#!/bin/bash

PLACEgif2mp4=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "gifからmp4を作成する"
		echo ". gif2mp4.sh (gif名) (mp4名)"
		return 0
	fi
fi
if [ $# = 2 ]
then
	ffmpeg -y -f gif -i ${1} ${2}
else
	echo "引数数が間違っています"
fi
cd $PLACEgif2mp4
