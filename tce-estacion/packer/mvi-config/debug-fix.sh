#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
#TSIZE=$(($TSIZE+14)) #Esta fijo en usr-lgz
MRSIZE=${TSIZE}M
