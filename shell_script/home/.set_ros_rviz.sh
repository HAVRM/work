#!/bin/bash

sleep 2s
PASS=`cd . && pwd`
rosrun rviz rviz -d ${PASS}/catkin_ws/src/Robocon_2016/launch/robocon2016_G.rviz
