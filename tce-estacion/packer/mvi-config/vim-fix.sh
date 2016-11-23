#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+2))
MRSIZE=${TSIZE}M

rm -rf usr/share/vim
