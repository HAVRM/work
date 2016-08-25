#!/bin/bash

PLACEwrite_little_endian=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "文字列をそのファイルの先頭に記す(改行の前にスペースを入れてください)"
		echo ". write_little_endian.sh (ファイル名(絶対アドレス)) ((文字列))"
		return 0
	fi
fi
if [ $# = 1 ]
then
	FNAME=$1
	ARG=" "
elif [ $# = 2 ]
then
	FNAME=$1
	ARG=$2
else
	echo "引数数が違います。-hを参照いてください"
	return 0
fi
PRE_IFS=$IFS
IFS=$'\n'
TXT=(`cat ${FNAME} 2> /dev/null`)
rm -rf $FNAME 2> /dev/null
echo $ARG >> ${FNAME}
for arg in ${TXT[@]}
do
	echo $arg >> ${FNAME}
done
IFS=${PRE_IFS}
cd $PLACEwrite_little_endian
