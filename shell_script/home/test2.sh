#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "説明"
		return 0
	fi
fi
sleep 20s &
echo $$
sleep 10s
