#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "rarファイルからpdfを作成"
		echo ". auto_making.sh ((作成後転送先)) (((並列数)))"
		return 0
	fi
fi
if [ $# = 1 ]
then
	LOCA=$1
	MNUM=3
elif [ $# = 2 ]
then
	LOCA=$1
	MNUM=$2
fi
set +m
NUM=0
RAR=(`ls | grep -i .rar`)
for arg in ${RAR[@]}
do
	. make_pdf.sh ${arg%.*} ${arg} ${NUM} & > /dev/null
	echo -e "\rstarting "${arg%.*}" by $!"
	NUM=`expr ${NUM} + 1`
	if [ $NUM = $MNUM ]
	then
		wait
		echo ""
		NUM=0
		if [ $# != 0 ]
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
