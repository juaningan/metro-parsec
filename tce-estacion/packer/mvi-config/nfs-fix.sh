#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+6))
MRSIZE=${TSIZE}M

echo "/home/metro/ControlId   -       nfs     rw" > etc/dfs/sharetab
