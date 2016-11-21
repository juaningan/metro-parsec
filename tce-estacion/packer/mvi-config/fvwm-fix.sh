#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+30))
MRSIZE=${TSIZE}M

mkdir -p usr/share/fvwm/
echo "DesktopSize 0 0" > usr/share/fvwm/config
