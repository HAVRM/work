#!/bin/bash

# . install_OpenCV249.shで実行
#インターネット接続が必要
#makeに３０分位かかるかも
# sudo apt-get install libopencv-devで手軽にインストールできるかもしれない（バージョンがどうなるかなど要確認）


if [ $USER = "root" ]
then
	echo "rootで実行しています。sudoなしで起動してください。終了します。"
	exit 0
else
	echo "------------------START------------------"
fi

#update
sudo apt-get update
sudo apt-get upgrade

#依存関係のインストール
sudo apt-get install build-essential libgtk2.0-dev libjpeg-dev libtiff4-dev libjasper-dev libopenexr-dev cmake python-dev python-numpy python-tk libtbb-dev libeigen3-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libqt4-dev libqt4-opengl-dev sphinx-common texlive-latex-extra libv4l-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev default-jdk ant libvtk5-qt4-dev

#OpenCVのダウンロード
mkdir ~/opencv_dir
cd ~/opencv_dir
wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip
unzip opencv-2.4.9.zip
cd opencv-2.4.9

#ビルド
mkdir build
cd build
cmake -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_VTK=ON ..

#make
make -j
sudo make install

#パスの設定
sudo echo "/usr/local/lib"| sudo tee -a /etc/ld.so.conf.d/opencv.conf
sudo ldconfig

#パスの設定２
sudo echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH"| sudo tee -a /etc/bash.bashrc

#サンプルのビルド
cd ~/opencv_dir/opencv-2.4.9/samples/c
chmod +x build_all.sh
./build_all.sh

#サンプルの実行
./facedetect --cascade="/usr/local/share/OpenCV/haarcascades/haarcascade_frontalface_alt.xml" --scale=1.5 lena.jpg

