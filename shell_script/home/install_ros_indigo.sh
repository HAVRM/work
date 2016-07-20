#!/bin/bash

# 実行方法
# . install_ros_indigo.sh

if [ $USER = "root" ]
then
	echo "rootで実行しています。sudoなしで起動してください。終了します。"
	exit 0
else
	echo "------------------START------------------"
fi

sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository main
sudo apt-add-repository restricted
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add –
sudo apt-get update
sudo apt-get install ros-indigo-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall

echo "-----------------------------------------"
echo "-ROSのインストール終了　catkin_wsを作成します-"
echo "-----------------------------------------"

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws/
catkin_make
echo "source /home/$USER/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
