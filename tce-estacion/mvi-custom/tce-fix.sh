#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+90))
MRSIZE=${TSIZE}M

curl --location https://github.com/juaningan/tce-estacion-config/archive/master.tar.gz -o parsec-tce-master.tar.gz
tar xvzf parsec-tce-master.tar.gz
cp -r parsec-tce-master/common/* ./
cp -r parsec-tce-master/nodes/pueblonuevo/* ./
rm -rf parsec-tce-*
rm -rf parsec-tce-*.tar.gz

sync
