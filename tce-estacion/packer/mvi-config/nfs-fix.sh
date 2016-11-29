#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+6))
MRSIZE=${TSIZE}M

echo "share -F nfs -o rw /home/metro/ControlId" >> etc/dfs/dfstab
