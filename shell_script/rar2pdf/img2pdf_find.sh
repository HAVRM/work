#!/bin/bash

PLACEimg2pdf_find=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "説明"
		echo ". img2pdf_find.sh (変換後名) ((rar)ファイル名) ((並列作業番号))"
		return 0
	fi
fi
#write progrum
NAME=$1
RAR=$2
THR=0
THR=`expr ${THR} + $3`
NUM=0
FT=""
if [ $# = 3 ]
then
	while [ $NUM -lt $THR ]
	do
		FT="${FT}\t\t"
		NUM=`expr ${NUM} + 1`
	done
	NUM=0
fi
if [ $# != 0 ]
then
	mkdir -p ${NAME}
	cp ${RAR} ${NAME}/${RAR} 2>/dev/null
	cd ${NAME}
	if [ $# != 3 ]
	then
		echo ${NAME}
	fi
	echo -e "\r${FT}[     ]解凍\c"
	unrar e ${RAR} 1>/dev/null 2>&1
	rm -f ${RAR} 2>/dev/null
	ls | grep -v -i -e .png -e .jpg -e .bmp -e .tif -e .jpeg | xargs rm -rf
	echo -e "\r${FT}[#    ]変更\c"
	ls | xargs -n8 -I{} convert {} pdf_{}.pdf 2> /dev/null
	echo -e "\r${FT}[##   ]圧縮\c"
	pdftk *.pdf cat output ${NAME}.pdf
	echo -e "\r${FT}[###  ]移動\c"
	mkdir -p /windows/pdf
	mkdir -p ../done_file
	mv ../${RAR} ../done_file/${RAR} 2> /dev/null
	mv ${NAME}.pdf /windows/pdf/${NAME}.pdf 2> /dev/null
	echo -e "\r${FT}[#### ]整理\c"
	cd ..
	rm -rf ${NAME}
	cd /tmp
	ls | grep image | xargs rm -rf
	cd ~/rar2pdf
	echo -e "\r${FT}[#####]終了\c"
fi
cd $PLACEimg2pdf_find
