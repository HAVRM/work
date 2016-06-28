#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "説明"
		return 0
	fi
fi
PD=`. test2.sh`
echo $PD
sleep 5s
kill -15 $PD
