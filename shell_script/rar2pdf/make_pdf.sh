#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "写真群からpdfを作る"
		echo ". make_pdf.sh (返還後名) ((rar)ファイル名) ((並列作業番号))"
		return 0
	fi
fi
NAME=$1
RAR=$2
THR=$3
THR=`expr ${THR} + 1`
NUM=0
FT=""
if [ $# = 3 ]
then
	while [ $NUM -lt $3 ]
	do
		FT="${FT}\t\t"
		NUM=`expr ${NUM} + 1`
	done
	NUM=0
fi
if [ $# != 0 ]
then
	mkdir -p ${NAME}
	cp ${RAR} ${NAME}/${RAR} 2> /dev/null
	cd ${NAME}
	if [ $# != 3 ]
	then
		echo ${NAME}
	fi
	echo -e "\r${FT}[        ]解凍\c"
	unrar e ${RAR} > /dev/null 2> /dev/null
	rm -f ${RAR} 2> /dev/null
	echo -e "\r${FT}[#       ]変更\c"
	cd ..
	. clear_exword.sh ${NAME}
	cd ${NAME}
	if [ $# != 3 ]
	then
		ls *.pdf 2>/dev/null | xargs -P0 -I{} convert -density 400 {} {}.png >/dev/null 2>&1
	else
		ls *.pdf 2>/dev/null | xargs -P2 -I{} convert -density 400 {} {}.png >/dev/null 2>&1
	fi
	ls | grep -v -i -e .png -e .jpg -e .bmp -e .tif -e .jpeg | xargs rm -rf
	echo -e "\r${FT}[##      ]圧縮1\c"
	PHT=(`ls`)
	if [ $# != 3 ]
	then
		ls | xargs -P0 -I{} convert {} done{}.png 2> /dev/null
	else
		ls | xargs -P2 -I{} convert {} done{}.png 2> /dev/null
	fi
	rm -f ${PHT[@]}
	echo -e "\r${FT}[###     ]圧縮2\c"
	PHT=(`ls`)
	if [ $# != 3 ]
	then
		ls | xargs -P0 -I{} convert {} done{}.jpg 2> /dev/null
	else
		ls | xargs -P2 -I{} convert {} done{}.jpg 2> /dev/null
	fi
	rm -f ${PHT[@]}
	echo -e "\r${FT}               \c"
	echo -e "\r${FT}[####    ]変名\c"
	PHT=(`ls`)
	FNU=`expr ${#PHT[*]} + 1`
	FNUM=(`seq -w 1 ${FNU}`)
	for arg in ${PHT[@]}
	do
		mv ${arg%.*}.jpg ${NAME}_${FNUM[${NUM}]}.jpg
		NUM=`expr ${NUM} + 1`
		rm -f ${arg} ${arg%.*}.png
	done
	echo -e "\r${FT}[#####   ]待機-\c"
	sleep ${THR}s
	WAIT=`cat ~/rar2pdf/wait.txt`
	while [ ${WAIT} != "0" ]
	do
		sleep 1s
		sleep ${THR}s
		WAIT=`cat ~/rar2pdf/wait.txt`
	done
	echo "${THR}" > ~/rar2pdf/wait.txt
	echo -e "\r${FT}[#####   ]待機 \c"
	MEM=`. ~/rar2pdf/mem_check.sh`
	sleep 1s
	sleep ${THR}s
	MEM2=`. ~/rar2pdf/mem_check.sh`
	while [ ${MEM} -ne ${MEM2} -o ${MEM2} -lt 50 ]
	do
		MEM=`. ~/rar2pdf/mem_check.sh`
		sleep 1s
		sleep ${THR}s
		MEM2=`. ~/rar2pdf/mem_check.sh`
	done
	echo -e "\r${FT}[######  ]変換\c"
	convert *.jpg ${NAME}.pdf & 2> /dev/null
	sleep 2s
	echo "0" > ~/rar2pdf/wait.txt
	wait
	echo -e "\r${FT}[####### ]整理\c"
	cd ..
	mkdir -p /windows/pdf
	mkdir -p done_file
	mv ${RAR} done_file/${RAR} 2> /dev/null
	mv ${NAME}/${NAME}.pdf /windows/pdf/${NAME}.pdf 2> /dev/null
	rm -rf ${NAME}
	if [ $# != 3 ]
	then
		echo -e "\r${FT}[########]終了:${NAME}.pdf"
	else
		echo -e "\r${FT}[########]終了\c"
	fi
	cd /tmp
	ls | grep image | xargs rm -rf
	cd ~/rar2pdf
else
	echo "please write param:\"name\" and \"rar file name\""
fi
