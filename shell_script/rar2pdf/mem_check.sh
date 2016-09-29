#!/bin/bash

PLACEmem_check=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "現在のメモリー残量を表示する"
		echo ". mem_check.sh"
		return 0
	fi
fi
total=$(free -m | awk '/Mem:/{print $2;}')
free=$(free -m | awk '/-\/+/{print $4;}')
free=${free}00
echo `expr $free / $total`
cd $PLACEmem_check
