#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "my_lib整理(追加)スクリプト"
		echo ". lib_sort.sh"
		return 0
	fi
fi
