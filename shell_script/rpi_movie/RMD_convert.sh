#!/bin/bash

PLACEconvert=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "rpiにてrecordmydesktopでとった画像の色調整"
		echo ". RMD_convert.sh (入力ファイル名) (出力力ファイル名)"
		return 0
	fi
fi
#write progrum
if [ $# != 2 ]
then
	echo "error:param error"
	return 0
fi
NAME=$1
FNAM=${1%.*}
OUTP=${2}
mkdir ${FNAM}
cp ${NAME} ${FNAM}/${NAME}
cp .enhance_green ${FNAM}/.enhance_green
cd ${FNAM}
ffmpeg -i ${NAME} -ss 0 -r 15 -f image2 -vcodec mjpeg -qscale 1 -qmin 1 -qmax 1 %08d.jpg
DATA=(`ls *.jpg`)
#for arg in ${DATA[@]}
#do
#	./.enhance_green ${arg} ${arg}
#done
ls *jpg | xargs -P0 -I{} ./.enhance_green {} {}
ffmpeg -f image2 -r 15 -i %08d.jpg -r 15 -an -vcodec libx264 ${OUTP%.*}.mp4
cd ..
cp -f ${FNAM}/${OUTP} ${OUTP}
rm -rf ${FNAM}
cd $PLACEconvert
