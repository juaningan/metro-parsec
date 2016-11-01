#!/usr/bin/bash -e -x
curl http://ftp1.digi.com/support/driver/40001174_T.bin -o 40001174_T.bin
pkgtrans 40001174_T.bin tmp/ all
rm -rf 40001174_T.bin
uncompress tmp/realport/reloc/opt/realport/i386/ncxd.Z
echo "  digi_realport    2048    262143  ldterm ttcompat" >> etc/iu.ap
echo "name=\"digi_realport\" parent=\"pseudo\" instance=0;" >> kernel/drv/digi_realport.conf
echo "forceload:      drv/digi_realport" >> etc/system
mv -f tmp/realport/reloc/opt/realport/i386/digi_realport kernel/drv/digi_realport
mv -f tmp/realport/reloc/opt ./
chmod -R +x opt/realport/*
add_drv -b ./ digi_realport
rm -rf opt/realport/sparc*
rm -rf opt/realport/amd64
rm -rf tmp/realport
