#!/bin/bash

PLACEsearch_fil=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "dropbox用のスクリプト。指定された場所の中にあるファイルのサイズと名前を取得する"
		echo ". search_fil.sh ((dropbox上の場所[ex:本/])))"
		return 0
	fi
fi
SFPREIFS=$IFS
IFS=$'\ \t\n'
if [ $# = 1 ]
then
	SFN=$1
else
	SFN=""
fi
SFNUMF=0
SFNUMD=0
SFNUM=0
SFDATA=(`. dropbox_uploader.sh list ${SFN}`)
for SFarg in ${SFDATA[@]}
do
	if [ $SFarg = "[F]" -a $SFNUMF != 0 ]
	then
		echo "" >> .temp_auto_update_f.txt
		SFNUM=1
	elif [ $SFarg = "[D]" -a $SFNUMD != 0 ]
	then
		echo "" >> .temp_auto_update_d.txt
		SFNUM=4
	elif [ $SFarg = "[F]" -a $SFNUMF = 0 ]
	then
		SFNUMF=1
		SFNUM=1
	elif [ $SFarg = "[D]" -a $SFNUMD = 0 ]
	then
		SFNUMD=1
		SFNUM=4
	elif [ $SFNUM = 1 ]
	then
		echo -e "${SFarg}\c" >> .temp_auto_update_f.txt
		SFNUM=2
	elif [ $SFNUM = 2 ]
	then
		echo -e " ${SFN}${SFarg}\c" >> .temp_auto_update_f.txt
		SFNUM=3
	elif [ $SFNUM = 3 ]
	then
		echo -e "\\ ${SFarg}\c" >> .temp_auto_update_f.txt
	elif [ $SFNUM = 4 ]
	then
		echo -e "${SFN}${SFarg}\c" >> .temp_auto_update_d.txt
		SFNUM=5
	elif [ $SFNUM = 5 ]
	then
		echo -e "\\ ${SFarg}\c" >> .temp_auto_update_d.txt
	fi
done

cd $PLACEsearch_fil
IFS=$SFPREIFS
