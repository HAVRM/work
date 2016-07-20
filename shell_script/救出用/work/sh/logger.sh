#!/bin/bash

cd ~/catkin_ws/src/robocon_logger/
DATA=`date '+%m%d%H%M%S'`
mkdir -p mylog/${DATA}
cd mylog/${DATA}
rosrun robocon_logger logger >& topic_log.txt
cd ~/
