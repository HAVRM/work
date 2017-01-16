#!/bin/bash

PLACEresize_photo=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "画像を目的サイズに拡大縮小する"
		echo ". resize_photo.sh (名前) (縦) (横)"
		return 0
	fi
fi
if [ $# = 3 ]
then
	convert -scale ${2}x${3}! ${1} ${1}
else
	echo "error param"
fi
cd $PLACEresize_photo
