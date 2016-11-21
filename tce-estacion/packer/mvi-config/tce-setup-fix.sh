#!/bin/bash

set -e
set -x
# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+7))
MRSIZE=${TSIZE}M

#Copy livecd installation scripts for test
cp /root/format-a-disk.sh root/

cat > metadata.json << EOF
"boot_archive":"${timestamp}"
"app":"nil"
"config:"nil"
EOF

ln -sf /usr/bin/sh usr/bin/distsh2 
ln -sf /usr/ucblib/libucb.so.1 usr/lib/libucb.so.1

echo 'metro:x:101:101::/home/metro:/bin/sh' >> etc/passwd                                                                                
echo 'metro:$6$1GrmvjyT$rXNSNGEma8eMmlTYBBzNQURNXAxHu8OvyPr9mXtxbhemWJi89hoZDm5ytSI4Z4NQbn2DDCEzDpZHQ27ikyCHS0:17120::::::' >> etc/shadow
echo 'metro::101:' >> etc/group
sed 's/^root.*$/root:pveboAFZFAX6c:16924::::::/g' etc/shadow > shadowtmp && mv shadowtmp etc/shadow

sync
