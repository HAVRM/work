#!/bin/bash

NAME=$1
RAR=$2
NUM=0
if [ $# != 0 ]
then
	mkdir -p ${NAME}
	mv ${RAR} ${NAME}/${RAR} 2> /dev/null
	cd ${NAME}
	echo -e "[    ]解凍\c"
	unrar e ${RAR} > /dev/null
	echo -e "\r[#   ]検索\c"
	PHT=(`ls | grep -i -e .png -e .jpg -e .bmp`)
	FNU=`expr ${#PHT[*]} + 1`
	FNUM=(`seq -w 1 ${FNU}`)
	for arg in ${PHT[@]}
	do
		echo -e "\r[##  ]圧縮(${NUM}/${FNU})\c"
		convert ${arg} ${arg%.*}.png
		convert ${arg%.*}.png ${arg%.*}.jpg
		mv ${arg%.*}.jpg ${NAME}_${FNUM[${NUM}]}.jpg 2> /dev/null
		NUM=`expr ${NUM} + 1`
		rm -f ${arg} ${arg%.*}.png 2> /dev/null
	done
	echo -e "\r[### ]変換                 \c"
	convert *.jpg ${NAME}.pdf
	cd ..
	mv ${NAME}/${NAME}.pdf pdf/${NAME}.pdf
	echo -e "\r[####]終了:${NAME}.pdf"
else
	echo "please write param:\"name\" and \"rar file name\""
fi
