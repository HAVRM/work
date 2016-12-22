#!/bin/bash

PLACEconnection=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "複数の動画ファイルをls順に1つにまとめる"
		echo ". connection.sh (.形式) ((場所))"
		return 0
	fi
fi
#write progrum

if [ $# = 2 ]
then
	cd $2
fi
mkdir done_file 1>/dev/null 2>&1
if [ $# -ge 1 ]
then
	SIZE=(`resize`)
	resize -s 24 105 1>/dev/null 2>&1
	MOV=(`ls | grep -i ${1}`)
	for arg in ${MOV[@]}
	do
		arg2=${arg%_*}
		PLC=`pwd`
		CON=(`ls 2>/dev/null | grep -i ${arg2}`)
		if [ ${#CON[@]} -ge 2 ]
		then
			for arg3 in ${CON[@]}
			do
				echo "file '${PLC}/${arg3}'" >> input.txt
			done
			ffmpeg -f concat -safe 0 -i input.txt -c copy done_file/${arg2}.flv | tr '\n' '\r'
			for arg3 in ${CON[@]}
			do
				mv ${arg3} done_file/${arg3}
			done
			rm -rf input.txt 1>/dev/null 2>&1
		fi
	done
	COL=${SIZE[0]#*=}
	COL=${COL%\;*}
	LIN=${SIZE[1]#*=}
	LIN=${LIN%\;*}
	resize -s ${LIN} ${COL} 1>/dev/null 2>&1
fi

cd $PLACEconnection
