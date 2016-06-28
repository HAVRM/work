#!/bin/bash

<< COM
PASS="***"
echo "what is your password:"
read PASS
echo $PASS
echo $PASS | sudo -S apt-get -y update
sudo apt-get upgrade <<\__EOF__
Y
__EOF__
COM

cd c*
