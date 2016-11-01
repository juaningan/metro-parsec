#!/bin/bash

set -e
set -x
# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+7))
MRSIZE=${TSIZE}M

#Copy livecd installation scripts for test
cp -v /root/format-a-disk.sh root/

sync
