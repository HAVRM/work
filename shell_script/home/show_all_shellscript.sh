#!/bin/bash

PLAC=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "shellscriptをリストアップする"
		echo ". show_all_shellscript.sh ((実行場所))"
		return 0
	fi
fi
if [ $# = 1 ]
then
	cd ${1}
fi
FILE=(`ls *.sh`)
for arg in ${FILE[@]}
do
	echo "${arg}:"
	. $arg -h
	echo ""
done
cd $PLAC
