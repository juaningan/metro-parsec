#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+15))
MRSIZE=${TSIZE}M

rm -rf usr/share/vim

# Link vi to vim
ln -sf /usr/bin/vim usr/bin/vi
