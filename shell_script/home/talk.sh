#!/bin/bash

PLACEtalk=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "Open-JTalkを使って音声をWAVで出力します"
		echo ". talk.sh (文字列) ((ファイル名))"
		return 0
	fi
fi
#write progrum
if [ $# = 1 ]
then
	TMP=~/open-talk.wav
	STR=$1
elif [ $# = 2 ]
then
	TMP=$2
	STR=$1
else
	echo "引数数が違います。-hで確認してください。"
	return 0
fi
echo "${STR}" | open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic -m /usr/share/hts-voice/nitech-jp-atr503-m001/nitech_jp_atr503_m001.htsvoice -ow ${TMP}
aplay -q ${TMP}
cd $PLACEtalk
