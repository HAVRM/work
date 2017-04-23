#!/bin/bash

PLACEauto_get_pdf=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "address_pdf.txtから\"アドレス 題名\"の形式で読み込み、ダウンロードする"
		echo "new_pdf.txtに変更ありの場合記載する"
		echo "自分のドロップボックスに転送する"
		echo "option:"
		echo -e "\t-fup:upload all pdf file"
		echo ". auto_get_pdf.sh ((-fup))"
		return 0
	elif [ $1 = "-fup" ]
	then
	        set +m
	        cd /home/***/auto_pdf/
	        rm -rf result.txt error.txt >/dev/null 2>&1
		DATA=`date +%m%d/%H`
		echo $DATA >>result.txt
		DATA=(`ls *.pdf`)
		for arg in ${DATA[@]}
		do
			echo ${arg}
			. dropbox_uploader.sh upload ${arg} ${arg} >>result.txt 2>terror.txt &
			wait
			cat terror.txt >>error.txt
			rm -rf terror.txt
		done
		. write_little_endian.sh new_pdf.txt
		. write_little_endian.sh new_pdf.txt "option_comand_by_-fup"
		DATA=`date +%y%m%d%H`
		. write_little_endian.sh new_pdf.txt ${DATA}
		echo "now uploading report"
		. dropbox_uploader.sh upload new_pdf.txt new_pdf.txt >>/dev/null 2>&1 &
		. dropbox_uploader.sh upload result.txt result.txt >>/dev/null 2>&1 &
		. dropbox_uploader.sh upload error.txt error.txt >>/dev/null 2>&1 &
		wait
		echo "finish uploading"
		set -m
		cd $PLACEauto_get_pdf
		return 0
	fi
fi
set +m
cd /home/***/auto_pdf/
rm -rf result.txt error.txt >/dev/null 2>&1
DATA=`date +%m%d/%H`
echo $DATA >>result.txt
echo "" >>result.txt
. dropbox_uploader.sh download address_pdf.txt address_pdf.txt >>result.txt 2>terror.txt &
wait
cat terror.txt >>error.txt
rm -rf terror.txt
. dropbox_uploader.sh download new_pdf.txt new_pdf.txt >>result.txt 2>terror.txt &
wait
cat terror.txt >>error.txt
rm -rf terror.txt
NUM=0
REN=0
WGRE=0
ERORNUM=0
NAME=""
ADDR=""
DATA=(`cat address_pdf.txt`)
for arg in ${DATA[@]}
do
	if [ $NUM = 1 ]
	then
		NAME=${arg}.pdf
		THE=`ls ${NAME} 2>/dev/null`
		if [ ! $THE ]
		then
			THE="no_file"
		fi
		echo ${ADDR} >>result.txt
		echo -e "${ADDR},\c"
		if [ ${THE} = ${NAME} ]
		then
			until wget -O temp_${NAME} ${ADDR} >>result.txt 2>terror.txt
			do
				WGRE=$?
				echo -e "${WGRE},\c"
				cat terror.txt >>error.txt
				rm -rf terror.txt
				echo "${NAME}:${WGRE}" >>error.txt
				ERORNUM=`expr ${ERORNUM} + 1`
				if [ $ERORNUM -ge 5 ]
				then
					echo -e "fatal:\c"
					echo "forced termination" >>error.txt
					break
				fi
				WGRE=0
				sleep 60s
			done
			echo $WGRE
			ERORNUM=0
			NOW=$(wc -c ${NAME} | awk '{print $1}')
			NEW=$(wc -c temp_${NAME} | awk '{print $1}')
			if [ ${NOW} -ge ${NEW} ]
			then
				rm -rf temp_${NAME} >>result.txt 2>/dev/null
			else
				rm -rf ${NAME} >>result.txt 2>/dev/null
				mv temp_${NAME} ${NAME}
				if [ $REN = 0 ]
				then
					. write_little_endian.sh new_pdf.txt
					REN=1
				fi
				. write_little_endian.sh new_pdf.txt ${NAME}
				. dropbox_uploader.sh upload ${NAME} ${NAME} >>result.txt 2>terror.txt &
				wait
				cat terror.txt >>error.txt
				rm -rf terror.txt
			fi
		else
			until wget -O ${NAME} ${ADDR} >>result.txt 2>terror.txt
			do
				WGRE=$?
				echo -e "${WGRE},\c"
				cat terror.txt >>error.txt
				rm -rf terror.txt
				echo "${NAME}:${WGRE}" >>error.txt
				ERORNUM=`expr ${ERORNUM} + 1`
				if [ $ERORNUM -ge 5 ]
				then
					echo -e "fatal:\c"
					echo "forced termination" >>error.txt
					break
				fi
				WGRE=0
				sleep 60s
			done
			echo $WGRE
			ERORNUM=0
			if [ $REN = 0 ]
			then
				. write_little_endian.sh new_pdf.txt
				REN=1
			fi
			. write_little_endian.sh new_pdf.txt "new:${NAME}"
			. dropbox_uploader.sh upload ${NAME} ${NAME} >>result.txt 2>terror.txt &
			wait
			cat terror.txt >>error.txt
			rm -rf terror.txt
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
DATA=`date '+%y%m%d%H'`
if [ $REN = 1 ]
then
	. write_little_endian.sh new_pdf.txt ${DATA}
fi
. rm_line.sh
. dropbox_uploader.sh upload new_pdf.txt new_pdf.txt >>result.txt 2>terror.txt &
echo "waiting for finish uploading" >>result.txt
echo "waiting for finish uploading"
wait
cat terror.txt >>error.txt
rm -rf terror.txt
. dropbox_uploader.sh upload error.txt error.txt >>/dev/null 2>&1 &
. dropbox_uploader.sh upload result.txt result.txt >>/dev/null 2>&1 &
echo "waiting for finish uploading report"
wait
set -m
cd $PLACEauto_get_pdf
