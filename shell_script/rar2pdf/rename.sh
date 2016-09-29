#!/bin/bash

PLACE=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "ファイル名のうち特定語を入れ替える"
		echo ". rename.sh (代入される語) ((代入する語)) (((実行場所)))"
		return 0
	fi
fi
if [ $# = 3 ]
then
	cd ${3}
	FILE=(`ls`)
	for arg in ${FILE[@]}
	do
		if [ `echo ${arg} | grep ${1}` ]
		then
			arg1=`echo ${arg} | sed -e s/${1}/${2}/g`
			mv ${arg} ${arg1}
		fi
	done
	cd $PLACE
elif [ $# = 2 ]
then
	FILE=(`ls`)
	for arg in ${FILE[@]}
	do
		if [ `echo ${arg} | grep ${1}` ]
		then
			arg1=`echo ${arg} | sed -e s/${1}/${2}/g`
			mv ${arg} ${arg1}
		fi
	done
elif [ $# = 1 ]
then
	FILE=(`ls`)
	for arg in ${FILE[@]}
	do
		if [ `echo ${arg} | grep ${1}` ]
		then
			arg1=`echo ${arg} | sed -e s/${1}//g`
			mv ${arg} ${arg1}
		fi
	done
fi
