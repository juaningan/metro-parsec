#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+40))
MRSIZE=${TSIZE}M
