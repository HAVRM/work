#!/bin/bash

make_result()
{
cd ~/mylog/${DATA}
echo "please answer the question"
echo "use camera/LRF? answer by y/n with ','.ex)y,n"
read UCL
echo "write end point and moving what. ex)pole(approach)&.."
read EPS
echo "write eco robo error point and why. ex)h2(fall)&.."
read EEP
echo "write hyb robo error point and why. ex)s2(hit)&.."
read HEP
echo "${UCL},${EPS},${EEP},${HEP},robocon_log" >> ${DATA}.csv
cd ~
}

cd ~
DATA=`date '+%m%d_%H%M_%S'`
DATA="${DATA}${1}"
echo ${DATA}
mkdir -p ~/mylog/${DATA}
CV=(`ls *.csv`)
cd ~/mylog/${DATA}
echo "start RC2016"
recordmydesktop 1> /dev/null 2> /dev/null &
RPID=$!
echo "if you want to deleate this log, please write 'd',"
echo "if you want to save this log, please write 's'"
read PARM
if [ $PARM = 'd' ]
then
	kill -9 $RPID
	cd ~/mylog
	rm -rf ${DATA}
else
	kill -15 $RPID
	make_result
fi
cd ~
