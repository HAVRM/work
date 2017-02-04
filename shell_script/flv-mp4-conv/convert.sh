#!/bin/bash

PLACEconvert=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "flvから同画質でmp4に変更する"
		echo ". convert.sh ((場所)) "
		return 0
	fi
fi
#write progrum
if [ $# != 0 ]
then
	cd $1
fi
mkdir mp4 >/dev/null 2>&1
mkdir done_file >/dev/null 2>&1
SIZE=(`resize`)
resize -s 24 105 1>/dev/null 2>&1
FLV=(`ls | grep -i -e .flv`)
for arg in ${FLV[@]}
do
	echo ${arg%.*}
	ffmpeg -threads 8 -i ${arg} -acodec copy -vcodec copy -y ${arg%.*}.mp4
	mv ${arg} done_file/${arg}
	mv ${arg%.*}.mp4 mp4/${arg%.*}.mp4
done
COL=${SIZE[0]#*=}
COL=${COL%\;*}
LIN=${SIZE[1]#*=}
LIN=${LIN%\;*}
resize -s ${LIN} ${COL} 1>/dev/null 2>&1
cd $PLACEconvert
