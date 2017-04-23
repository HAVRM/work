#!/bin/bash

PLACEimg2pdf_find=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "説明"
		echo ". img2pdf_find.sh (ファイル名)"
		return 0
	fi
fi
#write progrum
if [ $# = 1 ]
then
	NAME=$1
	cd ${NAME}
	ls | grep -v -i -e .png -e .jpg -e .bmp -e .tif -e .jpeg | xargs rm -rf
	ls | xargs -n8 -I{} convert {} pdf_{}.pdf 2> /dev/null
	pdftk *.pdf cat output ${NAME}.pdf
	mv ${NAME}.pdf ../${NAME}.pdf
	ls *.pdf | xargs rm -rf
	cd ..
fi
cd $PLACEimg2pdf_find
