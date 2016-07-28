#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "my_lib整理(追加)スクリプト"
		echo ". lib_sort.sh"
		return 0
	fi
fi
cd new_book/
PDFNAME=(`ls *.pdf 2> /dev/null`)
for arg in ${PDFNAME[@]}
do
	arg1=${arg%_*}
	PDFN=(`ls ${arg1}_*.pdf 2> /dev/null`)
	if [ ${#PDFN} != 0 ]
	then
		cd ..
		mkdir -p lib/${arg1}
		for arg2 in ${PDFN[@]}
		do
			mv new_book/${arg2} lib/${arg1}/${arg2} 2> /dev/null
		done
		cd new_book/
	fi
done
PDFNAME=(`ls *.pdf 2> /dev/null`)
for arg in ${PDFNAME[@]}
do
	cd ..
	mkdir -p lib/${arg%.*}
	mv new_book/${arg} lib/${arg%.*}/${arg} 2> /dev/null
	cd new_book/
done
cd ..
