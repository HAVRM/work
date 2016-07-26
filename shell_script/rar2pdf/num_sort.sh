#!/bin/bash

PLACEnum_sort=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "ファイル名の数を1,2桁から3桁にする。1ページ目から有効,0ページには対象外"
		echo ". num_sort.sh (変更する数の形式:0.jpg等<-唯一に絞れるように,数・桁は0で指定,＊は使用不可) ((実行場所))"
		return 0
	fi
fi
if [ $# = 0 ]
then
	echo "変更する形式を記入してください"
	return 0
fi
TYPE=$1
if [ $# = 2 ]
then
	LOCA=$2
else
	LOCA=${PLACEnum_sort}
fi
KETA=`echo $TYPE | sed "s/0/0\n/g" | grep -c "0"`
if [ $KETA = 0 ]
then
	echo "0を形式中に入れてください"
	return 0
else
	NUM=0
	FT=""
	while [ $NUM -lt $KETA ]
	do
		FT="${FT}0"
		NUM=`expr ${NUM} + 1`
	done
	NUM=0
fi
cd $LOCA
FNUM=99
NUM=1
for arg in `seq 0 ${FNUM}`
do
	if [ $KETA = 2 -a $arg -le 9 ]
	then
		arg1=`echo $TYPE | sed "s/${FT}/0${arg}/g"`
	else
		arg1=`echo $TYPE | sed "s/${FT}/${arg}/g"`
	fi
	if [ $arg -gt 9 ]
	then
		arg2=`echo $TYPE | sed "s/${FT}/0${arg}/g"`
	else
		arg2=`echo $TYPE | sed "s/${FT}/00${arg}/g"`
	fi
	FNAME=`ls $arg1 2> /dev/null`
	mv ${FNAME[0]} $arg2 2> /dev/null 1> /dev/null
	NUM=`expr ${NUM} + 1`
done
cd $PLACEnum_sort
