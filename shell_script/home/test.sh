#!/bin/bash

PASS="***"

#ttt()
#{
#echo "ttt"
#}

#echo $PASS | sudo -S useradd -m tester
#echo "move to tester"
#echo $PASS | sudo -S passwd tester <<\__EOF__
#tester
#tester
#__EOF__
#password_pass &


#PLACE=`pwd`
#PLACE=${PLACE##*/}
#if [ ${PLACE} = *** ]
#then
#	echo "***" | sudo -S -i -u tester . /home/***/test.sh
#else
#	echo "test" >test.txt
#fi

#USER="***"

#echo "#!/bin/bash

#echo \"ubuntu\" | sudo -S passwd ${USER} <<\__EOF__
#${PASS}
#${PASS}
#__EOF__" >ru14su_sub.sh

#sed -i -e "s/.\ .rm_user_ru14su_su.sh//" ~/test.txt

#echo "#!/bin/bash

#echo \". .rm_user_ru14su_su\" >>/home/${USER}/.bashrc
#echo \"echo \\\"${PASS}\\\" | sudo -S userdel -r ubuntu
#if [ \\\$? = 0 ]
#then
#	rm -rf .rm_user_ru14su_su.sh
#	sed -i -e \\\"s/.\ .rm_user_ru14su_su.sh//\\\" /home/${USER}/.bashrc\" >>.rm_user_ru14su_su.sh" >ru14su_sub.sh

#echo "---net_check---"
#ping 8.8.8.8 -c 5 | grep -q "icmp_seq=1"
#if [ $? = 1 ]
#then
#	echo "this machine is not in the internet"
#	return -1
#else
#	return 0
#fi
#echo ${PASS} | sudo -S useradd -m tester
#echo ${PASS} | sudo -S userdel -r tester

#nano tesnano <<\__EOF__
#asdf
#__EOF__
#gnome-terminal --geometry=100x10+0+0 -e 'bash echo "test"'
#import -window root -negate -crop 18x18+66+53 "test.jpg"
#echo "a" | nkf -g
#sed -i -e "s/\*\*\*/bbb/g" test.txt
#echo ${PASS} | sudo -S ln -s ~/work ~/test
#DATA=(`echo ${PASS} | sudo -S fdisk -l /dev/sdd`)
#GET=0
#for arg in ${DATA[@]}
#do
#	if [ ${GET} = 1 ]
#	then
#		break
#	elif [ ${arg} = "/dev/sdd2" ]
#	then
#		GET=1
#	fi
#done
#echo ${arg}
echo "echo $PASS | sudo -S fdisk  <<\__EOF__
d
2
n
p
2


w
__EOF__"
