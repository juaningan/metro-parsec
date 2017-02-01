#!/bin/bash

set -e
set -x

# Increase base size
MRSIZE=115M

USRSIZE=$(du -ks ./usr | awk '{print $1}')
USIZE=$(echo "(${USRSIZE} * 1.02) / 1" | bc)

rddir=$(pwd)
usrfile="${rddir}/usr.file"

mkfile ${USIZE}k ${usrfile}
lofidevusr=$(lofiadm -a "${usrfile}")

newfs -o space -m 0 -i 14000 -b 4096 ${lofidevusr} < /dev/null 2> /dev/null
mkdir -p ${rddir}/usr.dir
mount -F ufs -o nologging ${lofidevusr} "${rddir}/usr.dir"

mv ${rddir}/usr/* ${rddir}/usr.dir

(cd ${rddir}/usr.dir && tar cbf 512 - \
        bin/[ bin/cat bin/head bin/i86/ksh93 bin/ls \
        lib/libast.so lib/libast.so.1 lib/libcmd.so \
        lib/libcmd.so.1 lib/libdll.so lib/libdll.so.1 lib/libexacct.so \
        lib/libexacct.so.1 lib/libfstyp.so lib/libfstyp.so.1 lib/libidmap.so \
        lib/libidmap.so.1 lib/libipmi.so lib/libipmi.so.1 lib/libpkcs11.so \
        lib/libpkcs11.so.1 lib/libpool.so lib/libpool.so.1 lib/libproject.so \
        lib/libproject.so.1 lib/libshell.so lib/libshell.so.1 lib/libsmbios.so \
        lib/libsmbios.so.1 lib/libsum.so lib/libsum.so.1 sbin/lofiadm sbin/devfsadm) | \
        (cd ${rddir}/usr; tar xbf 512 -)

cd ${rddir}

umount -f "${rddir}/usr.dir"
rmdir ${rddir}/usr.dir

lofiadm -d "${lofidevusr}" 2>/dev/null
lofiadm -C gzip-9 ${usrfile}
mv ${usrfile} ${rddir}/usr.lgz
