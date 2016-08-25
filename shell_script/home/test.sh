#!/bin/bash

a1=`du -k install_ros_indigo.sh`
a2=`du -k install_OpenCV249.sh`
a3=$(du -k install_ros_indigo.sh | awk '{print $1}')
echo ${a3}
