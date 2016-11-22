#!/bin/bash

PASS="***"

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

echo "#!/bin/bash

echo \". .rm_user_ru14su_su\" >>/home/${USER}/.bashrc
echo \"echo \\\"${PASS}\\\" | sudo -S userdel -r ubuntu
if [ \\\$? = 0 ]
then
	rm -rf .rm_user_ru14su_su.sh
	sed -i -e \\\"s/.\ .rm_user_ru14su_su.sh//\\\" /home/${USER}/.bashrc\" >>.rm_user_ru14su_su.sh" >ru14su_sub.sh
