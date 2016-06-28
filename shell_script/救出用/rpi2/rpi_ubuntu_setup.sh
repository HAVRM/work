#!/bin/bash

# prease imput name which you want to inport : gnome,lubuntu,xubuntu,kubuntu,ros,rosserial,ros-LRF,opencv,avr

PASS="ubuntu"

ubuntu_update()
{
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y upgrade
echo $PASS | sudo -S apt-get update
}

ros_install()
{
echo "----ros----"
echo $PASS | sudo -S update-local LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
echo $PASS | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
ubuntu_update
echo $PASS | sudo -S apt-get -y install ros-indigo-ros-base ros-indigo-navigation python-rosdep python-rosinstall
echo $PASS | sudo -S rosdep init
rosdep update
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
catkin_make
cd ~
}

echo "start install package"
echo $PASS | sudo -S apt-get -y install dphys-swapfile
ubuntu_update
echo $PASS | sudo -S apt-get -y install linux-firmware openssh-server ssh
ubuntu_update
dt=0
ros=0
while [ $# -gt 0 ]
do
	if [ $1 = "gnome" ]
	then
		if [ $dt = 0 ]
		then
			dt=1
			echo "----gnome----"
			echo $PASS | sudo -S apt-get -y install ubuntu-desktop gnome-session-flashback
		fi
	elif [ $1 = "lubuntu" ]
	then
		if [ $dt = 0 ]
		then
			dt=1
			echo "----lubuntu----"
			echo $PASS | sudo -S apt-get -y install lubuntu-desktop
		fi
	elif [ $1 = "xubuntu" ]
	then
		if [ $dt = 0 ]
		then
			dt=1
			echo "----xubuntu----"
			echo $PASS | sudo -S apt-get -y install xubuntu-desktop
		fi
	elif [ $1 = "kubuntu" ]
	then
		if [ $dt = 0 ]
		then
			dt=1
			echo "----kubuntu----"
			echo $PASS | sudo -S apt-get -y install kubuntu-desktop
		fi
	elif [ $1 = "ros" ]
	then
		if [ $ros = 0 ]
		then
			ros_install
			ros=1
		fi
	elif [ $1 = "rosserial" ]
	then
		echo "----rosserial----"
		if [ $ros = 0 ]
		then
			ros_install
			ros=1
		fi
		echo $PASS | sudo -S apt-get -y install ros-indigo-rosserial-arduino ros-indigo-rosserial
	elif [ $1 = "ros-LRF" ]
	then
		echo "----ros-LRF----"
		<< COM
		if [ $ros = 0 ]
		then
			ros_install
			ros=1
		fi
		cd ~
		tar xzvf urgwidget_driver.tar.gz
		mv urgwidget_driver ~/catkin_ws/src/urgwidget_driver
		roscd urgwidget_driver
		rosmake
COM
		echo "have unknown rosmake error"
	elif [ $1 = "opencv" ]
	then
		echo "----opencv----"
		echo $PASS | sudo -S apt-get -y install build-essential libgtk2.0-dev libjpeg-dev libtiff4-dev libjasper-dev libopenexr-dev cmake python-dev python-numpy python-tk libtbb-dev libeigen3-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libqt4-dev libqt4-opengl-dev sphinx-common texlive-latex-extra libv4l-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev default-jdk ant libvtk5-qt4-dev
		mkdir ~/opencv_dir
		cd ~/opencv_dir
		wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip
		unzip opencv-2.4.9.zip
		cd opencv-2.4.9
		mkdir build
		cd build
		cmake -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=OFF -D WITH_VTK=ON ..
		make
		echo $PASS | sudo -S make install
		echo $PASS | sudo -S echo "/user/local/lib"| sudo tee -a /etc/ld.so.conf.d/opencv.conf
		echo $PASS | sudo -S ldconfig
		sudo echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH"| sudo tee -a /etc/bash.bashrc
		cd ~/opencv_dir/opencv-2.4.9/samples/c
		chmod +x build_all.sh
		./build_all.sh
		cd ~
	elif [ $1 = "avr" ]
	then
		echo "----avr----"
		DATA=(`ls hidspx*`)
		tar xzvf $DATA
		rm -f $DATA
		echo $PASS | sudo -S apt-get -y install gcc-avr binutils-avr avr-libc avrdude libusb-dev
		cd ~/hidspx*/src
		make
		echo $PASS | sudo -S make install
	fi
	ubuntu_update
	echo "${1} was finished"
	shift
done
echo "end of install"
sudo reboot
