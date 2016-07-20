#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "done_file,renamepdf以外のディレクトリーをrarに圧縮する"
		echo ". rar_make.sh"
		return 0
	fi
fi
FILE=(`ls`)
for arg in ${FILE[@]}
do
	arg1=${arg#*.}
	arg2=`expr ${#arg} - ${#arg1}`
	if [ ${arg2} = 0 ]
	then
		if [ ${arg} != "done_file" -a ${arg} != "renamepdf" ]
		then
				echo "${arg}"
				rar a ${arg}.rar ${arg} >/dev/null
				rm -rf ${arg}
		fi
	fi
done
