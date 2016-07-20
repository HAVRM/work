#!/bin/bash

PLACE=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "自分のgithubに関連することのコントロール"
		echo ". github_ctrl.sh"
		return 0
	fi
fi
. move_all_sh.sh *** *** *** *** *** ***
cd $PLACE
