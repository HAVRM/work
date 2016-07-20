#!/bin/bash

PLACE=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "ファイル名の' ','[',']'を'_'に変える"
		echo ". clear_exword (変換したいファイルがある場所)"
		return 0
	fi
fi
FNAME=$1
PRE_IFS=$IFS
IFS=$'\n'
cd ${FNAME}
PHT=(`ls`)
for arg in ${PHT[@]}
do
	mv $arg ${arg//\ /_} 2> /dev/null
done
PHT=(`ls`)
for arg in ${PHT[@]}
do
	mv $arg ${arg//\[/_} 2> /dev/null
done
PHT=(`ls`)
for arg in ${PHT[@]}
do
	mv $arg ${arg//\]/_} 2> /dev/null
done

cd $PLACE
IFS=${PRE_IFS}
