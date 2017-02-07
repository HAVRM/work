#!/bin/bash

PSTR=$@
INUM=$#
make_sh()
{
rm -rf .move_all_cpp_sub.sh
if [ ${INUM} != 0 ]
then
	echo "#!/bin/bash

NAME=\$1" >> .move_all_cpp_sub.sh
	ARG="sed -i "
	for arg in ${PSTR[@]}
	do
		ARG=${ARG}" -e \"s/${arg}/***/g\""
	done
	ARG=${ARG}" \${NAME}"
	echo ${ARG} >> .move_all_cpp_sub.sh
else
	echo "#!/bin/bash

:" >> .move_all_cpp_sub.sh
fi
}

if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo "すべて(公開可のもの)のcppをwork/cppに移動させる"
		echo ". move_all_cpp.sh ((パスワード1)) (((パスワード2))) ..."
		return 0
	fi
fi
rm -rf ~/work/cpp
FNAME=(`find ./ -name "*.cpp"`)
make_sh
. rm_~_file.sh
for arg in ${FNAME[@]}
do
	if [ `echo ${arg} | grep -i "catkin_ws"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "mylog"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "opencv_dir"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "work/cpp"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "Trash"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "set_ros"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "gigabyte"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "robocon"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "nhk"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "pepper_ws"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "naoqi"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "rosbuild_ws"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "gcc4mbed"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "siggraph2016_colorization"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "torch"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "rpi2_u14_work"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "open_jtalk"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "sketchbook"` ]
	then
		:
	elif [ `echo ${arg} | grep -i "robocon"` ]
	then
		:
	else
		arg2=${arg#*/}
		if [ ${arg2} = ${arg2%/*} ]
		then
			mkdir -p ~/work/cpp/home
			cp ${arg2} ~/work/cpp/home/${arg2}
			. .move_all_cpp_sub.sh ~/work/cpp/home/${arg2}
		else
			mkdir -p ~/work/cpp/${arg2%/*}
			cp ${arg2} ~/work/cpp/${arg2%/*}/${arg##*/}
			. .move_all_cpp_sub.sh ~/work/cpp/${arg2%/*}/${arg##*/}
		fi
	fi
done
