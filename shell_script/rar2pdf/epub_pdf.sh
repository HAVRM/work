#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo ".epubからpdfを作る"
		echo ". epub_pdf (pdf名) (epubファイル名) ((並列作業番号))"
		return 0
	fi
fi
NAME=$1
RAR=$2
NUM=0
FT=""
if [ $# = 3 ]
then
	while [ $NUM -lt $3 ]
	do
		FT="${FT}\t"
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
	echo -e "\r${FT}00解凍\c"
	unrar e ${RAR} > /dev/null
	echo -e "\r${FT}02変更\c"
	cd ..
	. clear_exword.sh ${NAME}
	cd ${NAME}
	echo -e "\r${FT}04待機\c"
	MEM=`. ~/rar2pdf/mem_check.sh`
	sleep 2s
	MEM2=`. ~/rar2pdf/mem_check.sh`
	while [ ${MEM} -gt ${MEM2} ]
	do
		MEM=`. ~/rar2pdf/mem_check.sh`
		sleep 2s
		MEM2=`. ~/rar2pdf/mem_check.sh`
	done
	while [ ${MEM} -lt 50 ]
	do
		sleep 5s
		MEM=`. ~/rar2pdf/mem_check.sh`
	done
	echo -e "\r${FT}06変換\c"
	PHT=(`ls | grep -i .epub`)
	ebook-convert ${PHT} ${NAME}.pdf > /dev/null
	echo -e "\r${FT}08整理\c"
	cd ..
	mkdir -p /windows/pdf
	mkdir -p done_file
	mv ${RAR} done_file/${RAR} 2> /dev/null
	mv ${NAME}/${NAME}.pdf /windows/pdf/${NAME}.pdf 2> /dev/null
	rm -rf ${NAME}
	if [ $# != 3 ]
	then
		echo -e "\r${FT}10終了:${NAME}.pdf"
	else
		echo -e "\r${FT}10終了\c"
	fi
else
	echo "please write param:\"name\" and \"rar file name\""
fi
