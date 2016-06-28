#!/bin/bash

PASS="***"
echo $PASS | sudo -S gnome-terminal --geometry=80x5+0+500 -e 'bash -c ". rosserial.sh"'
