#!/bin/bash

NAME=${1%.*}
rm -f comp.txt false.txt .${NAME}
if [ $# = 2 ]
then
	if [ $2="debug" ]
	then
		g++ ${NAME}.cpp -o .${NAME} -O0 -lopencv_core -lopencv_highgui -lopencv_imgproc 2> comp.txt
		valgrind ./.${NAME} 2> false.txt
	else
		g++ ${NAME}.cpp -o .${NAME} -lopencv_core -lopencv_highgui -lopencv_imgproc 2> comp.txt
		./.${NAME} 2> false.txt
	fi
else
	g++ ${NAME}.cpp -o .${NAME} -lopencv_core -lopencv_highgui -lopencv_imgproc 2> comp.txt
	./.${NAME} 2> false.txt
fi
