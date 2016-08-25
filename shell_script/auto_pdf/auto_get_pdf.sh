#!/bin/bash

PLACEauto_get_pdf=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "address_pdf.txtから\"アドレス 題名\"の形式で読み込み、ダウンロードする"
		echo "new_pdf.txtに変更ありの場合記載する"
		echo "自分のドロップボックスに転送する"
		echo ". auto_get_pdf.sh"
		return 0
	fi
fi
set +m
NUM=0
REN=0
NAME=""
ADDR=""
DATA=(`cat address_pdf.txt`)
for arg in ${DATA[@]}
do
	if [ $NUM = 1 ]
	then
		NAME=${arg}.pdf
		THE=`ls ${NAME} 2> /dev/null`
		if [ ! $THE ]
		then
			THE="no_file"
		fi
		echo ${NAME}
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
				. dropbox_uploader.sh upload ${NAME} ${NAME} >> /dev/null 2> error.txt &
			fi
		else
			wget -O ${NAME} ${ADDR} >> /dev/null 2> /dev/null
			if [ $REN = 0 ]
			then
				. write_little_endian.sh new_pdf.txt
				REN=1
			fi
			. write_little_endian.sh new_pdf.txt ${NAME}
			. dropbox_uploader.sh upload ${NAME} ${NAME} >> /dev/null 2> error.txt &
		fi
		NUM=0
	else
		ADDR=http://pdfnovels.net/${arg}/main.pdf
		if [ `echo ${arg} | grep n` ]
		then
			NUM=1
		fi
	fi
done
if [ $REN = 1 ]
then
	DATA=`date '+%y%m%d%H'`
	. write_little_endian.sh new_pdf.txt ${DATA}
fi
. rm_line.sh
. dropbox_uploader.sh upload new_pdf.txt new_pdf.txt >> /dev/null 2> error.txt &
echo "waiting for finish uploading"
wait
set -m
cd $PLACEauto_get_pdf
