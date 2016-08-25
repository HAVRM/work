#!/bin/bash

PLACEauto_get_pdf=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "address_pdf.shから\"アドレス 題名\"の形式で読み込み、ダウンロードする"
		echo "new_pdf.txtに変更ありの場合記載する"
		echo ". auto_get_pdf.sh"
		return 0
	fi
fi
NUM=0
REN=0
NAME=""
ADDR=""
DATA=(`cat address_pdf.sh`)
for arg in ${DATA[@]}
do
	if [ $NUM = 1 ]
	then
		NAME=$arg
		THE=`ls ${NAME} 2> /dev/null`
		if [ $THE = $NAME ]
		then
			wget -O temp_${NAME} ${ADDR} >> /dev/null 2> /dev/null
			NOW=$(du -k ${NAME} | awk '{print $1}')
			NEW=$(du -k temp_${NAME} | awk '{print $1}')
			DIFF=`expr $NEW - $NOW`
			if [ $DIFF = 0 ]
			then
				rm -rf temp_${NAME} >> /dev/null 2> /dev/null
			else
				rm -rf ${NAME} >> /dev/null 2> /dev/null
				mv temp_${NAME} ${NAME}
				if [ $REN = 0 ]
				then
					. write_little_endian.sh new_pdf.txt
					REN=1
				fi
				. write_little_endian.sh new_pdf.txt ${NAME}
			fi
		else
			wget -O ${NAME} ${ADDR} >> /dev/null 2> /dev/null
			if [ $REN = 0 ]
			then
				. write_little_endian.sh new_pdf.txt
				REN=1
			fi
			. write_little_endian.sh new_pdf.txt ${NAME}
		fi
		NUM=0
	else
		ADDR=$arg
		NUM=1
	fi
done
if [ $REN = 1 ]
then
	DATA=`date '+%y%m%d%H'`
	. write_little_endian.sh new_pdf.txt ${DATA}
fi
. rm_line.sh
cd $PLACEauto_get_pdf
