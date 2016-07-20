#!/bin/bash

FNAME=(`ls *.svg`)
for arg in ${FNAME[@]}
do
	convert ${arg} ${arg%.*}.png
done
