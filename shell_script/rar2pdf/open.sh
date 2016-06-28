#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "圧縮ファイルを展開する"
		echo ". unrar.sh"
		return 0
	fi
fi
. clear_space.sh ~/rar2pdf
FILE=(`ls *.rar`)
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
FILE=(`ls *.zip`)
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
