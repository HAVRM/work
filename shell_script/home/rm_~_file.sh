#!/bin/bash

cd ~
find ./ -name '*~' | xargs rm -f
cd /windows
find ./ -name '*~' | xargs rm -f
cd ~
