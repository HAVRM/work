#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "圧縮ファイルを展開する"
		echo ". open.sh"
		return 0
	fi
fi
. clear_exword.sh ~/rar2pdf
FILE=(`ls *.rar 2> /dev/null`)
for arg in ${FILE[@]}
do
	echo ${arg}
	mkdir ${arg%.*}
	mv ${arg} ${arg%.*}/${arg}
	cd ${arg%.*}
	unrar e ${arg} > /dev/null 2> /dev/null
	rm -rf ${arg}
	cd ..
done
FILE=(`ls *.zip 2> /dev/null`)
for arg in ${FILE[@]}
do
	echo ${arg}
	mkdir ${arg%.*}
	mv ${arg} ${arg%.*}/${arg}
	cd ${arg%.*}
	unzip ${arg} > /dev/null 2> /dev/null
	rm -rf ${arg}
	cd ..
done
