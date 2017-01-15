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

PDF="/media/***/HDPC-UT/pdf_book/pdf/"

cd $PDF
FIL=(`ls *.pdf`)
for arg in ${FIL[@]}
do
	echo ${arg}
	mkdir ~/done_file/${arg%.*}
	cp ${arg} ~/done_file/${arg%.*}/${arg}
	cd ~/done_file/${arg%.*}
	pdftk ${arg} cat 1-4 output ${arg%.*}_sub1.pdf
	pdftk ${arg} cat r4-r1 output ${arg%.*}_sub2.pdf
	rm ${arg}
	set +m
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[0] ${arg%.*}_0.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[1] ${arg%.*}_1.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[2] ${arg%.*}_2.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub1.pdf[3] ${arg%.*}_3.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[0] ${arg%.*}_4.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[1] ${arg%.*}_5.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[2] ${arg%.*}_6.jpg &
	convert -density 600 -geometry 1000 ${arg%.*}_sub2.pdf[3] ${arg%.*}_7.jpg &
	wait
	set -m
	rm ${arg%.*}_sub1.pdf ${arg%.*}_sub2.pdf
	cd /tmp
	ls | grep magick | xargs rm -rf
	trash-empty
	cd $PDF
done
cd ~
