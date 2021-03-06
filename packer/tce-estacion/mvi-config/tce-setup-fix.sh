#!/bin/bash

set -e
set -x
# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+15))
MRSIZE=${TSIZE}M

#Copy livecd installation scripts for test
cp /root/format-a-disk.sh root/

cat > metadata.json << EOF
"boot_archive":"${timestamp}"
"app":"nil"
"config:"nil"
EOF

ln -sf /usr/bin/sh usr/bin/distsh2 

# Clean UCB and copy lib
mv usr/ucblib/libucb.so.1 usr/lib/libucb.so.1
rm -rf usr/ucb/*
ln -sf /usr/bin/rsh usr/ucb/rsh

# Create metro user
echo 'metro:x:101:101::/home/metro:/bin/sh' >> etc/passwd
echo 'metro:$6$1GrmvjyT$rXNSNGEma8eMmlTYBBzNQURNXAxHu8OvyPr9mXtxbhemWJi89hoZDm5ytSI4Z4NQbn2DDCEzDpZHQ27ikyCHS0:17120::::::' >> etc/shadow
echo 'metro::101:' >> etc/group

# Set timezone
sed 's/^TZ.*$/TZ\=Europe\/Madrid/g' etc/default/init > inittmp && mv inittmp etc/default/init

# Set graphical terminal
cat > usr/bin/xterm << EOF
#!/bin/sh
/usr/bin/mrxvt
EOF
chmod +x usr/bin/xterm

# Clean locales
rm -rf usr/share/locale
rm -rf usr/share/X11/locale

# Clean tcl package (expect required)
rm -rf usr/lib/thread2.8.0
rm -rf usr/lib/tdbc*
rm -rf usr/lib/tcl8
rm -rf usr/lib/itcl*

# Download TCE bin and libs
wget "http://16.0.96.20/repo/pctce/pctce-bin.tar.gz" -O /tmp/pctce-bin.tar.gz
/tmp/usr/gnu/bin/tar -C ./ -xzf /tmp/pctce-bin.tar.gz

# license
mkdir -p usr/local/tce
ln -sf /home/metro/control.key usr/local/tce/tce

# Link csh to tcsh and bash to ksh
ln -sf /usr/bin/tcsh usr/bin/csh
ln -sf /usr/bin/sh usr/bin/bash

# Copy closed source iprb driver
/usr/bin/cp -p  /tmp/files/iprb kernel/drv/iprb
chmod 0644 kernel/drv/iprb
chown root:sys kernel/drv/iprb

# Put logadm rules in etc/logadm.conf
sed 's/^smf_logs.*/smf_logs \/var\/svc\/log\/*.log -C 3 -s 100k -c/g' etc/logadm.conf > logadmtmp && mv logadmtmp etc/logadm.conf
cat /tmp/files/logadm-metro.conf >> etc/logadm.conf

# Copy manual ftp binary while not tribblix package exists
cp /tmp/files/ftpd/in.ftpd usr/sbin/in.ftpd
cp /tmp/files/ftpd/ftp* etc/ftpd/

sync
