#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "my_lib統括スクリプト"
		echo ". lib.sh"
		return 0
	fi
fi
