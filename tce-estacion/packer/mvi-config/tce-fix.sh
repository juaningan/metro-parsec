#!/bin/bash

set -e
set -x

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+90))
MRSIZE=${TSIZE}M

echo $DESTDIR
echo $PWD

wget -q "https://github.com/juaningan/tce-estacion-config/archive/master.tar.gz" -O - | /tmp/usr/gnu/bin/tar -C ${DESTDIR} -xzf - tce-estacion-config-master/common --strip-components=2

sync
