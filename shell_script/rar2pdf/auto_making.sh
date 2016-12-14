#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "rarファイルからpdfを作成"
		echo ". auto_making.sh ((作成後転送先)) (((並列数))) ((((並列数))))"
		return 0
	fi
fi
set +m
MNUM=4
MENUM=8
if [ $# = 1 ]
then
	LOCA=$1
	MNUM=4
elif [ $# = 2 ]
then
	LOCA=$1
	MNUM=$2
elif [ $# = 3 ]
then
	LOCA=$1
	MNUM=$2
	MENUM=$3
fi
WNUM=0
. rar_make.sh
echo " "
EPUB=(`ls | grep -i .epub`)
for arg in ${EPUB[@]}
do
	. epub_pdf.sh ${arg%.*} ${arg} ${WNUM} & > /dev/null
	echo -e "\rstarting "${arg%.*}" by $!"
	WNUM=`expr ${WNUM} + 1`
	if [ $WNUM = $MENUM ]
	then
		wait
		echo ""
		WNUM=0
		if [ $# != 0 ]
		then
			cd /windows/pdf
			PHT=(`ls`)
			for arg in ${PHT[@]}
			do
				arg2=${arg%.*}
				arg3="${arg2}.epub"
				arg2="${arg2}.rar"
				mv ${arg} ${LOCA}${arg}
				mv ~/rar2pdf/done_file/${arg2} ${LOCA}done_file/${arg2} 2> /dev/null
				mv ~/rar2pdf/done_file/${arg3} ${LOCA}done_file/${arg3} 2> /dev/null
			done
			cd ~/rar2pdf
		fi
		echo " "
	fi
done
wait
WNUM=0
if [ $# != 0 ]
then
	cd /windows/pdf
	PHT=(`ls`)
	for arg in ${PHT[@]}
	do
		arg2=${arg%.*}
		arg3="${arg2}.epub"
		arg2="${arg2}.rar"
		mv ${arg} ${LOCA}${arg}
		mv ~/rar2pdf/done_file/${arg2} ${LOCA}done_file/${arg2} 2> /dev/null
		mv ~/rar2pdf/done_file/${arg3} ${LOCA}done_file/${arg3} 2> /dev/null
	done
	cd ~/rar2pdf
fi
echo " "
RAR=(`ls | grep -i .rar`)
echo "0" > ~/rar2pdf/wait.txt
for arg in ${RAR[@]}
do
	. make_pdf.sh ${arg%.*} ${arg} ${WNUM} & > /dev/null
	echo -e "\rstarting "${arg%.*}" by $!"
	WNUM=`expr ${WNUM} + 1`
	if [ $WNUM = $MNUM ]
	then
		wait
		echo ""
		WNUM=0
		if [ $# != 0 ]
		then
			cd /windows/pdf
			PHT=(`ls`)
			for arg in ${PHT[@]}
			do
				arg2=${arg%.*}
				arg3="${arg2}.epub"
				arg2="${arg2}.rar"
				mv ${arg} ${LOCA}${arg}
				mv ~/rar2pdf/done_file/${arg2} ${LOCA}done_file/${arg2} 2> /dev/null
				mv ~/rar2pdf/done_file/${arg3} ${LOCA}done_file/${arg3} 2> /dev/null
			done
			cd ~/rar2pdf
		fi
		echo " "
	fi
done
wait
if [ $# != 0 ]
then
	cd /windows/pdf
	PHT=(`ls`)
	for arg in ${PHT[@]}
	do
		arg2=${arg%.*}
		arg3="${arg2}.epub"
		arg2="${arg2}.rar"
		mv ${arg} ${LOCA}${arg}
		mv ~/rar2pdf/done_file/${arg2} ${LOCA}done_file/${arg2} 2> /dev/null
		mv ~/rar2pdf/done_file/${arg3} ${LOCA}done_file/${arg3} 2> /dev/null
	done
	cd ~/rar2pdf
fi
echo " "
rm  -rf ~/rar2pdf/wait.txt
set -m
