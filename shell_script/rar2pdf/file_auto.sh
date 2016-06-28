#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "ファイルをpdfに変換する"
		echo ". file_auto.sh (シリーズ名) ((作成後転送場所))"
		return 0
	fi
fi
if [ $# = 2 ]
then
	LOCA=$2
fi
set +m
NUM=0
if [ $# != 0 ]
then
	NAME=$1
	FILE=(`ls | grep -i ${NAME}`)
	for arg in ${FILE[@]}
	do
		. make_pdf.sh ${arg} ${arg}.rar ${NUM} & > /dev/null
		echo -e "\rstarting "${arg%.*}" by $!"
		NUM=`expr ${NUM} + 1`
		if [ $NUM = 3 ]
		then
			wait
			echo ""
			NUM=0
			if [ $# = 2 ]
			then
				cd /windows/pdf
				PHT=(`ls`)
				for arg in ${PHT[@]}
				do
					mv ${arg} ${LOCA}${arg}
				done
				cd ~/rar2pdf
			fi
		fi
	done
	wait
	echo ""
	set -m
else
	echo "prease put series name"
fi
