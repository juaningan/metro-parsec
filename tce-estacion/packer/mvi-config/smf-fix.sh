#!/bin/bash

set -e
set -x
# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+15))
MRSIZE=${TSIZE}M

sed 's/^root.*$/root:pveboAFZFAX6c:16924::::::/g' etc/shadow > shadowtmp && mv shadowtmp etc/shadow
sed 's/\/usr\/bin\/bash$/\/bin\/sh/g' etc/passwd > passwdtmp && mv passwdtmp etc/passwd

# Clean fma
/usr/bin/rm -rf usr/platform/i86pc/lib/fm

/usr/bin/rm -rf etc/svc/profile/*
/usr/bin/cp -p /tmp/smf/method/* lib/svc/method/
/usr/bin/cp -p /tmp/smf/profile/generic.xml etc/svc/profile/generic.xml
/usr/bin/ln -s generic.xml etc/svc/profile/platform.xml
chmod +x lib/svc/method/*

/usr/bin/rm -f etc/rctladm.conf

/usr/bin/rm -rf /lib/svc/manifest/*
/usr/bin/cp -rp /tmp/smf/manifest/* /lib/svc/manifest/

(cd lib/svc/manifest/ && tar cbf 512 - \
  milestone/name-services.xml \
  milestone/network.xml \
  milestone/single-user.xml \
  milestone/sysconfig.xml \
  milestone/multi-user.xml \
  milestone/multi-user-server.xml \
  system/boot-archive.xml \
  system/sysevent.xml \
  system/rmtmpfiles.xml \
  system/hostid.xml \
  system/cryptosvc.xml \
  system/manifest-import.xml \
  system/utmp.xml \
  system/console-login.xml \
  system/filesystem/local-fs.xml \
  system/cron.xml \
  system/boot-config.xml \
  system/identity.xml \
  system/svc/restarter.xml \
  system/device/devices-local.xml \
  system/device/devices-audio.xml \
  system/filesystem/root-fs.xml \
  system/filesystem/usr-fs.xml \
  system/filesystem/minimal-fs.xml \
  network/inetd.xml \
  network/login.xml \
  network/shell.xml \
  network/time.xml \
  network/dlmgmt.xml \
  network/network-netcfg.xml \
  network/network-ipmgmt.xml \
  network/network-loopback.xml \
  network/network-physical.xml \
  network/network-initial.xml \
  network/network-netmask.xml \
  network/network-service.xml \
  network/network-routing-setup.xml \
  network/ssh.xml \
  network/ipfilter.xml \
  network/nfs/status.xml \
  network/nfs/nlockmgr.xml \
  network/nfs/server.xml \
  network/nfs/client.xml \
  network/nfs/mapid.xml \
  network/shares/group.xml \
  network/rpc/bind.xml) | \
  (cd /lib/svc/manifest/; tar xbf 512 -)

#  network/shares/reparsed.xml \

rm -rf lib/svc/manifest/*
cp -rp /lib/svc/manifest/* lib/svc/manifest/

/lib/svc/method/manifest-import -f etc/svc/repository.db -d /lib/svc/manifest/
