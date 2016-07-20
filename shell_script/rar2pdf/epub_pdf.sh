#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo ".epubからpdfを作る"
		echo ". epub_pdf (pdf名) (epubファイル名)"
		return 0
	fi
fi
NAME=$1
RAR=$2
if [ $# != 0 ]
then
	mkdir -p ${NAME}
	cp ${RAR} ${NAME}/${RAR} 2> /dev/null
	cd ${NAME}
	echo ${NAME}
	echo -e "[    ]解凍\c"
	unrar e ${RAR} > /dev/null
	echo -e "\r[#   ]変更\c"
	cd ..
	. clear_exword.sh ${NAME}
	cd ${NAME}
	echo -e "\r[##  ]変換\c"
	PHT=(`ls | grep -i .epub`)
	ebook-convert ${PHT} ${NAME}.pdf > /dev/null
	echo -e "\r[### ]整理\c"
	cd ..
	mkdir -p /windows/pdf
	mkdir -p done_file
	mv ${RAR} done_file/${RAR} 2> /dev/null
	mv ${NAME}/${NAME}.pdf /windows/pdf/${NAME}.pdf 2> /dev/null
	rm -rf ${NAME}
	echo -e "\r[####]終了:${NAME}.pdf"
else
	echo "please write param:\"name\" and \"rar file name\""
fi
