#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+20))
MRSIZE=${TSIZE}M

# Clean tcl package
rm -rf usr/lib/thread2.8.0
rm -rf usr/lib/tdbc*
rm -rf usr/lib/tcl8
rm -rf usr/lib/itcl*
