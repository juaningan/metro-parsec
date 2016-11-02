#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+90))
MRSIZE=${TSIZE}M

wget -q "https://github.com/juaningan/tce-estacion-config/archive/master.tar.gz" -O parsec-tce-master.tar.gz
/tmp/usr/gnu/bin/tar xvzf parsec-tce-master.tar.gz
cp -r tce-estacion-config-master/common/* ./
cp -r tce-estacion-config-master/nodes/pueblonuevo/* ./
rm -rf parsec-tce-*
rm -rf parsec-tce-*.tar.gz

sync
