#!/bin/bash

#インターネット接続状態で実行
#ubuntu14.04用
#下のNAME,PASS,GITNAME,GITMAIL,GITPASSの中を編集するGIT..はgithubにおけるもの
#インストールするものは関数化されていて一番最後のupdate_upgrade以下の行が
#それぞれ何をインストールするかを指定している。インストールしなくていい物は
#それが書かれている先頭に'#'をつければいい。
#例: ros_install->#ros_install

NAME="***" #PC username ___@...:~$
PASS="***" #PC password
GITNAME="HAVRM" #github username
GITMAIL="***@gmail.com" #github mail address
GITPASS="***" #github password

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
wget https://github.com/HAVRM/work/raw/master/install/urgwidget_driver.tar.gz
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
./facedetect --cascade="/usr/local/share/OpenCV/haarcascades/haarcascade_frontalface_alt.xml" --scale=1.5 lena.jpg &
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
cd ~
}

github_setting()
{
echo "---github_setting---"
cd ~
update_upgrade
mkdir work
cd ~/work
git init
git remote rm work
git remote add work https://${GITNAME}:${GITPASS}@github.com/HAVRM/work.git
git fetch work
git merge work/master
git config --global user.name "${GITNAME}"
git config --global user.email "${GITMAIL}"
cd shell_script/home
cp rm_~_file.sh ~/rm_~_file.sh
. ~/rm_~_file.sh
cp update_upgrade.sh ~/update_upgrade.sh
sed -i -e "s/\*\*\*/${PASS}/" ~/update_upgrade.sh
cd ~
}

tiger_vnc_install()
{
echo "---vnc_install---"
cd ~
update_upgrade
echo $PASS | sudo -S add-apt-repository ppa:ikuya-fruitsbasket/tigervnc
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y install tigervncserver
#tigervncpasswd <<\__EOF__
#{vncpass}
#{vncpass}
#n
#__EOF__
#rm -f .auto_vnc.sh
#echo "#!/bin/bash
#
#gnome-terminal --geometry=0x0+0+0 -e 'bash -c \"x0vncserver -display :0 -passwordfile ~/.vnc/passwd\"'" >> ~/.auto_vnc.sh
#echo ". .auto_vnc.sh" >> ~/.bashrc
cd ~
}

open_jtalk()
{
echo "---open-jtalk---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install open-jtalk open-jtalk-mecab-naist-jdic hts-voice-nitech-jp-atr503-m001
wget https://raw.githubusercontent.com/HAVRM/work/master/shell_script/home/talk.sh
cd ~
}

st_linkv2()
{
echo "---st_linkv2---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install libusb-1.0
wget https://raw.githubusercontent.com/HAVRM/work/master/install/49-stlinkv2-1.rules
echo $PASS | sudo -S cp 49-stlinkv2-1.rules /etc/udev/rules.d
echo $PASS | sudo -S udevadm control --reload-rules
rm -rf 49-stlinkv2-1.rules
cd ~
}

gcc4mbed()
{
echo "---gcc4mbed---"
cd ~
update_upgrade
mkdir gcc4mbed
cd gcc4mbed
wget https://github.com/adamgreen/gcc4mbed/zipball/master
echo $PASS | sudo -S apt-get -y install lib32z1 lib32ncurses5 lib32bz2-1.0
unzip master
rm -rf master
cd adamgreen*
. linux_install
cd ~
}

arduino()
{
echo "---arduino---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install arduino
cd ~
}

avr()
{
echo "---avr---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install gcc-avr binutils-avr avr-libc avrdude libusb-dev
wget https://github.com/HAVRM/work/raw/master/install/hidspx-2014-0306.tar.gz
tar xzvf hidspx-2014-0306.tar.gz
rm -rf hidspx-2014-0306.tar.gz
cd ~/hidspx-2014-0306/src
make
echo $PASS | sudo -S make install
cd ~
mkdir AVR_mbed
cd AVR_mbed
git remote add AVR_mbed https://${GITNAME}:${GITPASS}@github.com/HAVRM/AVR_mbed.git
git fetch AVR_mbed
git merge AVR_mbed/master
cd ~
}

xpresso_ide_pre()
{
echo "---xpresso_ide_pre---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install libgtk2.0-0:i386 libxtst6:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 libglu1-mesa:i386 libncurses5:i386 libudev1:i386 libusb-1.0:i386 libusb-0.1:i386 gtk2-engines-murrine:i386 libnss3-1d:i386
cd ~
}

wine()
{
echo "---wine---"
cd ~
update_upgrade
echo $PASS | sudo -S add-apt-repository ppa:ubuntu-wine/ppa
update_upgrade
echo $PASS | sudo -S apt-get -y install wine1.7 winetricks
}

teamviewer()
{
echo "---teamviewer---"
cd ~
update_upgrade
wget http://www.teamviewer.com/download/teamviewer_linux.deb
echo $PASS | sudo -S dpkg --add-architecture i386
update_upgrade
echo $PASS | sudo -S apt-get -y install gdebi
echo $PASS | sudo -S gdebi teamviewer_linux.deb
cd ~
}

other_install()
{
echo "---other_install---"
cd ~
update_upgrade
echo $PASS | sudo -S apt-get -y install recordmydesktop imagemagick rar unrar pdftk screen git
echo $PASS | sudo -S add-apt-repository ppa:mc3man/trusty-media <<\__EOF__

__EOF__
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y install ffmpeg
echo $PASS | sudo -S sh -c 'echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf'
echo $PASS | sudo -S restart systemd-logind
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
github_setting
tiger_vnc_install
open_jtalk
st_linkv2
gcc4mbed
arduino
avr
xpresso_ide_pre
wine
teamviewer
other_install
update_upgrade
cd ~
