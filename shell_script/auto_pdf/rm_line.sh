#!/bin/bash

PLACErm_line=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "auto_pdf専門スクリプト。1年前より前のデータを削除"
		echo ". rm_line.sh"
		return 0
	fi
fi
PRE_IFS=$IFS
IFS=$'\n'
DATA=(`cat new_pdf.txt`)
rm -rf new_pdf.txt >> /dev/null 2> /dev/null
LIM=`date '+%y%m%d%H'`
LIM=`expr $LIM - 1000000`
NUM=0
for arg in ${DATA[@]}
do
	if [ $NUM = 0 ]
	then
		LIM=$arg
		LIM=`expr $LIM - 1000000`
		NUM=1
	fi
	expr $arg + 1 > /dev/null 2>&1
	STR=$?
	if [ ${STR} -lt 2 ]
	then
		if [ ${arg} -lt ${LIM} ]
		then
			break
		fi
	fi
	echo $arg >> new_pdf.txt
done
IFS=$'\ \t\n'
cd $PLACErm_line
