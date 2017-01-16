#!/bin/bash

PLACEconvert_pdf2jpg=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "説明"
		echo ". convert_pdf2jpg.sh"
		return 0
	fi
fi
PDF="/media/***/HDPC-UT/pdf_book/pdf/"

cd $PDF
FIL=(`ls *.pdf`)
for arg in ${FIL[@]}
do
	echo ${arg}
	mkdir ~/done_file/${arg%.*}
	cp ${arg} ~/done_file/${arg%.*}/${arg}
	cd ~/done_file/${arg%.*}
	pdftk ${arg} cat 1-4 output ${arg%.*}_sub1.pdf
	pdftk ${arg} cat r4-r1 output ${arg%.*}_sub2.pdf
	rm ${arg}
	set +m
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[0] ${arg%.*}_0.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[1] ${arg%.*}_1.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[2] ${arg%.*}_2.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[3] ${arg%.*}_3.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[0] ${arg%.*}_4.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[1] ${arg%.*}_5.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[2] ${arg%.*}_6.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[3] ${arg%.*}_7.jpg &
	wait
	set -m
	rm ${arg%.*}_sub1.pdf ${arg%.*}_sub2.pdf
	cd /tmp
	ls | grep magick | xargs rm -rf
	trash-empty
	cd $PDF
done
cd $PLACEconvert_pdf2jpg
