#!/bin/bash

PLACEreverse=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "画像をまとめて反転させる"
		echo ". inverse.sh (検索文字列) ((場所/))"
		return 0
	fi
fi
#write progrum
if [ $# = 1 ]
then
	NAME=$1
elif [ $# = 2 ]
then
	NUM=$#
	NAME=$1
	cp .threshold ${2}.threshold
	cd $2
else
	echo "write right param"
	return 0
fi
ls ${NAME} | xargs -P0 -I{} ./.threshold {} {}
if [ $NUM = 2 ]
then
	rm -rf .threshold
fi
cd $PLACEreverse
