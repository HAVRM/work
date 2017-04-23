#!/bin/bash

PSTR=$@
INUM=$#
make_sh()
{
rm -rf .move_all_sh_sub.sh
if [ ${INUM} != 0 ]
then
	echo "#!/bin/bash

NAME=\$1" >> .move_all_sh_sub.sh
	ARG="sed -i "
	for arg in ${PSTR[@]}
	do
		ARG=${ARG}" -e \"s/${arg}/***/g\""
	done
	ARG=${ARG}" \${NAME}"
	echo ${ARG} >> .move_all_sh_sub.sh
else
	echo "#!/bin/bash

:" >> .move_all_sh_sub.sh
fi
}

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "すべて(公開可のもの)のshellscriptをwork/shell_scriptに移動させる"
		echo ". move_all_sh.sh ((パスワード1)) (((パスワード2))) ..."
		return 0
	fi
fi
rm -rf ~/rpi2_u14_work/shell_script
FNAME=(`find ./ -name "*.sh"`)
make_sh
. rm_~_file.sh
for arg in ${FNAME[@]}
do
	if [ `echo ${arg} | grep -i "catkin_ws"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "opencv_dir"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "rpi2_u14_work/shell_script"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "Trash"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "gcc4mbed"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "torch"` ]
	then
		:
	else
		arg2=${arg#*/}
		if [ ${arg2} = ${arg2%/*} ]
		then
			mkdir -p ~/rpi2_u14_work/shell_script/home
			cp ${arg2} ~/rpi2_u14_work/shell_script/home/${arg2}
			. .move_all_sh_sub.sh ~/rpi2_u14_work/shell_script/home/${arg2}
		else
			mkdir -p ~/rpi2_u14_work/shell_script/${arg2%/*}
			cp ${arg2} ~/rpi2_u14_work/shell_script/${arg2%/*}/${arg##*/}
			. .move_all_sh_sub.sh ~/rpi2_u14_work/shell_script/${arg2%/*}/${arg##*/}
		fi
	fi
done
