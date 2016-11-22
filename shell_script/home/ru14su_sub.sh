#!/bin/bash

echo ". .rm_user_ru14su_su" >>/home/***/.bashrc
echo "echo \"***\" | sudo -S userdel -r ubuntu
if [ \$? = 0 ]
then
	rm -rf .rm_user_ru14su_su.sh
	sed -i -e \"s/.\ .rm_user_ru14su_su.sh//\" /home/***/.bashrc" >>.rm_user_ru14su_su.sh
