#!/bin/bash

gnome-terminal --geometry=0x0+0+0 -e 'bash -c "x0vncserver -display :0 -passwordfile ~/.vnc/passwd"'
