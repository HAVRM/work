#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "my_lib検索プログラム"
		echo ". lib_search.sh"
		return 0
	fi
fi
