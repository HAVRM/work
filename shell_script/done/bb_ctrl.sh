#!/bin/bash

PLACErename_bc=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "本棚作成用シェルスクリプト"
		echo ". bb_ctrl.sh (コマンド) (場所)"
		echo "   --bcname   :背表紙の名前を\"XXX_*.xxx\"から\"XXX__BC.xxx\"とする。"
		echo "   --bctitle  :背表紙の名前を
              \"(親フォルダと同じ名前)__BC.xxxとする。場所は
              フォルダ郡の親フォルダ。変更後外に出し、フォルダを削除する"
		echo "   --resize   :中にある画像のサイズを48x360にする"
		echo "   --rotate   :中にある画像を90度回転させる"
		return 0
	fi
fi
#write progrum
if [ $# = 2 ]
then
	cd $2
	if [ $1 = "--bcname" ]
	then
		FILE=(`ls`)
		for arg in ${FILE[@]}
		do
			if [ `echo ${arg} | grep '__BC'` ]
			then
				:
			else
				mv $arg "${arg%_*}__BC.${arg##*.}"
			fi
		done
	elif [ $1 = "--bctitle" ]
	then
		FOL=(`ls`)
		for arg in ${FOL[@]}
		do
			arg1=${arg#*.}
			arg2=`expr ${#arg} - ${#arg1}`
			if [ ${arg2} = 0 ]
			then
				cd $arg1
				FIL=`ls`
				if [ ${FIL} ]
				then
					mv ${FIL} "../${arg1}__BC.${FIL##*.}"
					cd ..
					rm -rf ${arg1}
				else
					cd ..
				fi
			fi
		done
	elif [ $1 = "--resize" ]
	then
		FIL=(`ls | grep -i -e .png -e .jpg -e .bmp -e .tif -e .jpeg`)
		for arg in ${FIL[@]}
		do
			convert -scale 48x360! ${arg} ${arg}
		done
	elif [ $1 = "--rotate" ]
	then
		FIL=(`ls | grep -i -e .png -e .jpg -e .bmp -e .tif -e .jpeg`)
		for arg in ${FIL[@]}
		do
			convert -rotate 90 ${arg} ${arg}
		done
	else
		echo "wrong option"
	fi
fi
cd $PLACErename_bc
