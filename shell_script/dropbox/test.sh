#!/bin/bash

DATA=(`. dropbox_uploader.sh list`)
echo "fin:reading list"
NUM=0
for arg in ${DATA[@]}
do
	if [ $arg = "[F]" -a $NUM != 0 ]
	then
		echo "" >> temp_auto_update.txt
		NUM=1
	elif [ $arg = "[D]" -a $NUM != 0 ]
	then
		echo "" >> temp_auto_update.txt
		NUM=2
	elif [ $arg = "[F]" -a $NUM = 0 ]
	then
		NUM=1
	elif [ $arg = "[D]" -a $NUM = 0 ]
	then
		NUM=2
	elif [ $NUM = 1 ]
	then
		NUM=2
	elif [ $NUM = 2 ]
	then
		echo -e "${arg} \c" >> .temp_auto_update.txt
	fi
done
echo "fin:making list"
DATA=(`cat .temp_auto_update.txt`)
for arg in ${DATA[@]}
do
	. dropbox_uploader.sh download ${arg} &
	wait
done
rm -rf .temp_auto_update.txt
