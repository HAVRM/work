#!/bin/bash

PLACEphoto_jp=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "入力された文字列の画像を返す"
		echo ". photo_jp.sh (+ or -)(文字) ((名前)) (((文字色))) (((背景色))) (((設定)))"
		echo "               +:横書き"
		echo "               -:縦書"
		echo ""
		echo -e "      色:0->\033[0;47;30m　　黒　　\033[0;39m"
		echo -e "         1->\033[0;47;31m　　赤　　\033[0;39m"
		echo -e "         2->\033[0;47;32m　　緑　　\033[0;39m"
		echo -e "         3->\033[0;47;33m　　黄　　\033[0;39m"
		echo -e "         4->\033[0;47;34m　　青　　\033[0;39m"
		echo -e "         5->\033[0;47;35m マゼンダ \033[0;39m"
		echo -e "         6->\033[0;47;36m　シアン　\033[0;39m"
		echo -e "         7->\033[0;40;37m　　白　　\033[0;39m"
		echo -e "         7->\033[0;49;39m　初期値　\033[0;39m"
		echo ""
		echo -e "    設定:0->\033[0;39m ノーマル \033[0;39m"
		echo -e "         1->\033[1;39m　 太字 　\033[0;39m"
		echo -e "         4->\033[4;39m　 下線 　\033[0;39m"
		echo -e "         5->\033[5;39m　 点滅 　\033[0;39m"
		echo -e "         7->\033[7;39m　色反転　\033[0;39m <-default"
		echo -e "         8->\033[8;39m\033[0;39m　(隠す)　"
#		return 0
	fi
fi
if [ $# = 1 ]
then
	CHAR=$1
	DIR=`echo ${CHAR} | cut -c 1`
	CHAR=`echo ${CHAR} | cut -c 2-`
	CON=7
	BC=9
	CC=9
	NAME=`date '+%m%d_%H%M_%S'`
	NAME="screenshot_"${NAME}".jpg"
elif [ $# = 2 ]
then
	CHAR=$1
	DIR=`echo ${CHAR} | cut -c 1`
	CHAR=`echo ${CHAR} | cut -c 2-`
	CON=7
	BC=9
	CC=9
	NAME=$2
elif [ $# = 5 ]
then
	CHAR=$1
	DIR=`echo ${CHAR} | cut -c 1`
	CHAR=`echo ${CHAR} | cut -c 2-`
	CON=$5
	BC=$4
	CC=$3
	NAME=$2
else
	echo "miss param"
	return 0
fi

STR=(`echo ${CHAR} | while read -N 1 i;do echo ${i};done`)
FIL=0
for arg in ${STR[@]}
do
	CCODE=`echo ${arg} | nkf -g`
	if [ ${CCODE} = "ASCII" ]
	then
		echo "#!/bin/bash

echo -e \"\033[${CON};4${BC};3${CC}m ${arg} \033[0;39m\"
I=0
while [ \$I -ne 50 ]
do
	I=\`expr \$I + 1\`
done
import -window root -crop 18x18+71+53 \"${NAME}_sub.jpg\"
">.photo_jp_sub.sh
	else
		echo "#!/bin/bash

echo -e \"\033[${CON};4${BC};3${CC}m${arg} \033[0;39m\"
I=0
while [ \$I -ne 50 ]
do
	I=\`expr \$I + 1\`
done
import -window root -crop 18x18+66+53 \"${NAME}_sub.jpg\"
">.photo_jp_sub.sh
	fi
	gnome-terminal --geometry=2x3+0+0 -e 'bash -c ". .photo_jp_sub.sh"'
	sleep 1s
	if [ $FIL = 0 ]
	then
		sleep 1s
		cp ${NAME}_sub.jpg ${NAME}
		FIL=1
	else
		convert ${DIR}append ${NAME} ${NAME}_sub.jpg ${NAME}
	fi
done
rm .photo_jp_sub.sh ${NAME}_sub.jpg
echo ${PLACEphoto_jp}/${NAME}
cd $PLACEphoto_jp
