#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "my_lib貸出(転送)スクリプト"
		echo ". lib_rent.sh"
		return 0
	fi
fi
