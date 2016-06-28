#!/bin/bash

PCE=$1
NAME=$2
cd $PCE
if [ $# = 3 ]
then
	recordmydesktop --workdir=${PCE} --output=${NAME} 1> /dev/null 2> /dev/null &
	RPID=$!
else
	recordmydesktop --workdir=${PCE} --output=${NAME}
fi
if [ $# = 3 ]
then
	TIME=$3
	TIME=${TIME}"s"
	sleep ${TIME}
	kill -15 $RPID
fi
cd ~
