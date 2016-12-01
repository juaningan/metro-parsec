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

# Add NFS share
echo "share -F nfs -o rw /home/metro/ControlId" >> etc/dfs/dfstab

# Clean locales
rm -rf usr/share/locale
rm -rf usr/share/X11/locale

# Clean tcl package (expect required)
rm -rf usr/lib/thread2.8.0
rm -rf usr/lib/tdbc*
rm -rf usr/lib/tcl8
rm -rf usr/lib/itcl*

# usr/local
mkdir usr/local
ln -s /usr/bin usr/local/bin

# Link csh to tcsh and bash to ksh
ln -sf /usr/bin/tcsh usr/bin/csh
ln -sf /usr/bin/sh usr/bin/bash

# Link rlogin to ssh
ln -sf /usr/bin/ssh usr/bin/rsh
ln -sf /usr/bin/ssh usr/ucb/rsh
ln -sf /usr/bin/scp usr/bin/rcp

# Link for some binaries
ln -sf /home/metro/sun/check_host usr/bin/check_host
ln -sf /home/metro/sun/cmd_tout usr/bin/cmd_tout
ln -sf /home/metro/sun/MandaEnvio.ksh usr/bin/MandaEnvio.ksh
ln -sf /home/metro/sun/PreparaEnvio.ksh usr/bin/PreparaEnvio.ksh

sync
