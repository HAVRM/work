#!/bin/bash

PASS="***"
#if [ echo ${https_proxy} ]
#then
#	echo $PASS | sudo -S -E apt-get update
#	echo $PASS | sudo -S -E apt-get -y upgrade
#else
	echo $PASS | sudo -S apt-get update
	echo $PASS | sudo -S apt-get -y upgrade
#fi
