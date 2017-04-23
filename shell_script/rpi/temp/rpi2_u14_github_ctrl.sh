#!/bin/bash

PLACE=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "自分のgithubに関連することのコントロール"
		echo ". github_ctrl.sh (pull)"
		return 0
	fi
fi
COM=$1
NCOM=$#
DATA=`date '+%m%d_%H%M_%S'`
cd ~/rpi2_u14_work
git checkout master
cd ~
if [ ${NCOM} = 1 ]
then
	if [ ${COM} = "pull" ]
	then
		cd ~/rpi2_u14_work
		git fetch rpi2_u14_work
		git merge rpi2_u14_work/master
		cd $PLACE
		return 0
	fi
fi
. move_all_sh.sh *** *** *** *** *** *** *** nA8dCNyPuQQ
cp -rf ~/html ~/rpi2_u14_work
cd ~/rpi2_u14_work
git add -A
git commit -m "${DATA}"
git push rpi2_u14_work master
cd $PLACE
