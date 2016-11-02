#!/bin/bash

#実行方法は 「. ubuntu_setup.sh」を端末で打ち込んで実行
#インターネット接続状態で実行
#ubuntu14.04での動作確認済み
#下のNAME,PASSの***を編集する（""は消さない）
#インストールするものは関数化されていて一番最後のupdate_upgrade以下の行が
#それぞれ何をインストールするかを指定している。インストールしなくていい物は
#それが書かれている先頭に'#'をつければいい。
#例: ros_install->#ros_install

NAME="***" #PC username ___@...:~$
PASS="***" #PC password

update_upgrade()
{
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y upgrade
}

ros_install()
{
echo "---ros_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-add-repository universe
echo $PASS | sudo -S apt-add-repository multiverse
echo $PASS | sudo -S apt-add-repository main
echo $PASS | sudo -S apt-add-repository restricted
echo $PASS | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y install ros-indigo-desktop-full
echo $PASS | sudo -S rosdep init
rosdep update
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc
echo $PASS | sudo -S apt-get -y install python-rosinstall
mkdir -p ~/catkin_ws/src
cd ~/catkin_make/src
catkin_init_workspace
cd ~/catkin_ws
catkin_make
echo "source /home/${NAME}/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
cd ~
}

rosserial_install()
{
echo "---rosserial_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install ros-indigo-rosserial-arduino
echo $PASS | sudo -S apt-get -y install ros-indigo-rosserial
cd ~
}

LRF_install()
{
echo "---urg_node_install---"
cd ~
update_upgrade
wget https://github.com/***/work/raw/master/install/urgwidget_driver.tar.gz
tar xzvf urgwidget_driver.tar.gz
mv urgwidget_driver ~/catkin_ws/src/urgwidget_driver
roscd urgwidget_driver
rosmake
cd ~
rm -f urgwidget_driver.tar.gz
cd ~
}

opencv_install()
{
echo "---open_cv_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install build-essential libgtk2.0-dev libjpeg-dev libtiff4-dev libjasper-dev libopenexr-dev cmake python-dev python-numpy python-tk libtbb-dev libeigen3-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libqt4-dev libqt4-opengl-dev sphinx-common texlive-latex-extra libv4l-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev default-jdk ant libvtk5-qt4-dev
mkdir ~/opencv_dir
cd ~/opencv_dir
wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip
unzip opencv-2.4.9.zip
cd opencv-2.4.9
mkdir build
cd build
cmake -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_VTK=ON ..
make -j8
echo $PASS | sudo -S make install
sudo echo "/usr/local/lib"| sudo tee -a /etc/ld.so.conf.d/opencv.conf
echo $PASS | sudo -S ldconfig
sudo echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH"| sudo tee -a /etc/bash.bashrc
cd ~/opencv_dir/opencv-2.4.9/samples/c
chmod +x build_all.sh
./build_all.sh
cd ~
}

ar_tool_install()
{
echo "---ar_tool_install---"
cd ~
update_upgrade
wstool init ~/catkin_ws/src
cd ~/catkin_ws
wstool set -y --target-workspace=src ar_tools --git https://github.com/ar-tools/ar_tools.git
wstool update ar_tools --target-workspace=src ar_tools
cd ~/catkin_ws/src
rosdep install -iy --from-paths ar_tools
cd ~/catkin_ws
source ~/.bashrc
catkin_make
echo $PASS | sudo -S apt-get -y install ros-indigo-camera-umd
cd ~/catkin_ws/src
rm -Rf ar_tools
cd ~
}

other_install()
{
echo "---other_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install recordmydesktop
cd ~
}

echo "yor name is ${NAME}, password is ${PASS}"
echo "your github name is ${GITNAME}, mail is ${GITMAIL}, password is ${GITPASS}"
update_upgrade
ros_install
rosserial_install
LRF_install
opencv_install
ar_tool_install
other_install
update_upgrade
cd ~
