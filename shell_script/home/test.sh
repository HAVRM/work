#!/bin/bash

PASS="***"
sed -i -e "s/\*\*\*/${PASS}/" update_upgrade.sh
