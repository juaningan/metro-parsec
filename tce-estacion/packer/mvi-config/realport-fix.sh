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

cat > usr/bin/realport.sh << 'EOF'
#!/sbin/sh
#

DRIVER_NAME="digi_realport"
RPDAEMON="/usr/bin/ncxd"
RPMKNODS="/usr/bin/ncx_mknod"
RPMKLINKS="/usr/bin/ncx_make_links"

DFT_IP_PORT=771

tty_dir_name="dty"
txprint_dir_name="dpr"
cua_dir_name="cua"
term_dir_name="term"

get_major() {
 major_number=0
 while read name major; do
   if [[ ${name} = ${DRIVER_NAME} ]]; then
     major_number=$major
     break
   fi
 done < /etc/name_to_major
}

get_major

uis_ip=$1
psn=0
devid="EL"
ndev=16
secureopt="never"

$RPMKNODS ${major_number} ${psn} ${devid} ${ndev} ${tty_dir_name} ${txprint_dir_name}
$RPMKLINKS "/dev/${tty_dir_name}" ${devid} "s" ${ndev} "/dev/${cua_dir_name}"
$RPMKLINKS "/dev/${tty_dir_name}" ${devid} "m" ${ndev} "/dev/${term_dir_name}"
$RPDAEMON -d /dev/${DRIVER_NAME}${psn} -i ${uis_ip} -p $DFT_IP_PORT -e $secureopt

ln -sf /dev/dty/${devid}001s /dev/ttys01
ln -sf /dev/dty/${devid}002s /dev/ttys02
ln -sf /dev/dty/${devid}003s /dev/ttys03
ln -sf /dev/dty/${devid}004s /dev/ttys04
ln -sf /dev/dty/${devid}005s /dev/ttys05
ln -sf /dev/dty/${devid}006s /dev/ttys06
ln -sf /dev/dty/${devid}007s /dev/ttys07
ln -sf /dev/dty/${devid}008s /dev/ttys08
ln -sf /dev/dty/${devid}009s /dev/ttys09
ln -sf /dev/dty/${devid}010s /dev/ttys10
ln -sf /dev/dty/${devid}011s /dev/ttys11
ln -sf /dev/dty/${devid}012s /dev/ttys12
ln -sf /dev/dty/${devid}013s /dev/ttys13
ln -sf /dev/dty/${devid}014s /dev/ttys14
ln -sf /dev/dty/${devid}015s /dev/ttys15
ln -sf /dev/dty/${devid}016s /dev/ttys16
EOF

chmod +x usr/bin/realport.sh
