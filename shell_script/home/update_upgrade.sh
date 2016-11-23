#!/bin/bash

PASS="***"
echo $PASS | sudo -S apt-get update
echo $PASS | sudo -S apt-get -y upgrade
