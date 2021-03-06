#!/usr/bin/bash -e -x
wget -q "http://ftp1.digi.com/support/driver/40001174_T.bin" -O 40001174_T.bin
pkgtrans 40001174_T.bin tmp/ all
rm -rf 40001174_T.bin
uncompress tmp/realport/reloc/opt/realport/i386/ncxd.Z
echo "  digi_realport    2048    262143  ldterm ttcompat" >> etc/iu.ap
echo "name=\"digi_realport\" parent=\"pseudo\" instance=0;" >> kernel/drv/digi_realport.conf
echo "forceload:      drv/digi_realport" >> etc/system

mv -f tmp/realport/reloc/opt/realport/i386/digi_realport kernel/drv/digi_realport
add_drv -b ./ digi_realport

chmod +x tmp/realport/reloc/opt/realport/i386/ncx*
mv -f tmp/realport/reloc/opt/realport/i386/ncxd usr/bin/
mv -f tmp/realport/reloc/opt/realport/i386/ncx_make_links usr/bin/
mv -f tmp/realport/reloc/opt/realport/i386/ncx_mknod usr/bin/
rm -rf tmp/realport
