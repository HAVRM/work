#!/bin/bash

echo "please write your password to setup"
PASS="***"
#echo $PASS | sudo -S apt-get install recordmydesktop
gedit ~/catkin_ws/src/Robocon_2016/route/0route.csv ~/catkin_ws/src/Robocon_2016/route/0plots.csv &
nautilus ~/catkin_ws/src/Robocon_2016/route
echo $PASS | sudo -S gnome-terminal --geometry=80x5+0+500 &
cd ~/catkin_ws/src/Robocon_2016/shell_script
