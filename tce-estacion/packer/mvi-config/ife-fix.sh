#!/usr/bin/bash -e
wget -q "http://freenicdrivers.la.coocan.jp/taiyodo/ife-2.6.2.tar.gz" -O ife-2.6.2.tar.gz
/tmp/usr/gnu/bin/tar -xzf ife-2.6.2.tar.gz
mv -f ife-2.6.2/i386/* kernel/drv/

DEVLIST=("pci8086,1229" "pci8086,1209" "pci8086,1029" "pci8086,1030" "pci8086,1031" "pci8086,1032" "pci8086,1033" "pci8086,1034" "pci8086,1035" "pci8086,1036" "pci8086,1037" "pci8086,1038" "pci8086,1039" "pci8086,103a" "pci8086,103b" "pci8086,103c" "pci8086,103d" "pci8086,103e" "pci8086,1050" "pci8086,1051" "pci8086,1052" "pci8086,1053" "pci8086,1054" "pci8086,1055" "pci8086,1056" "pci8086,1057" "pci8086,1059" "pci8086,1064" "pci8086,1065" "pci8086,1066" "pci8086,1067" "pci8086,1068" "pci8086,1069" "pci8086,106a" "pci8086,106b" "pci8086,1091" "pci8086,1092" "pci8086,1093" "pci8086,1094" "pci8086,1095" "pci8086,1227" "pci8086,1228" "pci8086,2449" "pci8086,2459" "pci8086,245d" "pci8086,27dc" "pci8086,5200" "pci8086,5201")

for i in ${DEVLIST[@]}; do
  if grep "ife " etc/driver_aliases >/dev/null ; then
    /usr/sbin/update_drv -b ./ -a -v -m '* 0600 root sys' -i "$i" ife
  else
    /usr/sbin/add_drv -b ./ -n -v -m '* 0600 root sys' -i "$i" ife
  fi
done

rm -rf ife-*

sync
