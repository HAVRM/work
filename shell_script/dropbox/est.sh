#!/bin/bash

DATA=(`cat .temp_auto_update_d.txt`)
for arg in ${DATA[@]}
do
	echo $arg
done
