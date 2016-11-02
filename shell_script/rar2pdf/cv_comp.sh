#!/bin/bash

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "open cvのプログラムをコンパイルする"
		echo ". cv_comp.sh (コンパイルするソースファイル.cpp)"
		return 0
	fi
fi
NAME=${1%.*}
if [ $# = 2 ]
then
	if [ $2="debug" ]
	then
		g++ ${NAME}.cpp -o .${NAME} -O0 -lopencv_core -lopencv_highgui -lopencv_imgproc
	else
		g++ ${NAME}.cpp -o .${NAME} -lopencv_core -lopencv_highgui -lopencv_imgproc
	fi
else
	g++ ${NAME}.cpp -o .${NAME} -lopencv_core -lopencv_highgui -lopencv_imgproc
fi
