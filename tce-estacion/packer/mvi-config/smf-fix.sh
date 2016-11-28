#!/bin/bash

set -e
set -x
# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+15))
MRSIZE=${TSIZE}M

sed 's/^root.*$/root:pveboAFZFAX6c:16924::::::/g' etc/shadow > shadowtmp && mv shadowtmp etc/shadow
sed 's/\/usr\/bin\/bash$/\/bin\/sh/g' etc/passwd > passwdtmp && mv passwdtmp etc/passwd

/usr/bin/rm -rf etc/svc/profile/*
/usr/bin/cp -p /tmp/smf/method/* lib/svc/method/
/usr/bin/cp -p /tmp/smf/profile/generic.xml etc/svc/profile/generic.xml
/usr/bin/cp -rp /tmp/smf/manifest/* lib/svc/manifest/
/usr/bin/ln -s generic.xml etc/svc/profile/platform.xml
chmod +x lib/svc/method/*

/usr/bin/rm -f etc/rctladm.conf

/usr/bin/rm -rf /lib/svc/manifest/*
/usr/bin/cp -pr lib/svc/manifest/* /lib/svc/manifest/
/lib/svc/method/manifest-import -f etc/svc/repository.db -d /lib/svc/manifest/
