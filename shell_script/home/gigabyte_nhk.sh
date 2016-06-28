#!/bin/bash

gnome-terminal --geometry=0x0+0+0 --tab -e 'bash -c ". .set_ros_sub1_nhk.sh"' --tab -e 'bash -c ". .set_ros_sub2.sh"' --tab -e 'bash -c ". .set_ros_sub3.sh"' --tab -e 'bash -c ". .set_ros_roscore.sh"' --tab -e 'bash -c ". .set_ros_rviz.sh"'
. auto_vnc.sh
cd ~/catkin_ws/src/Robocon_2016/shell_script
sleep 5s
. robocon_G_log.sh
