#!/bin/bash -eux
echo "Removing development packages and cleaning up DNF data"
dnf -y remove gcc cpp gc kernel-devel kernel-headers glibc-devel glibc-headers kernel-devel kernel-headers make 
dnf -y autoremove
dnf -y clean all --enablerepo=\*

# delete any logs that have built up during the install
#find /var/log/ -name *.log -exec rm -f {} \;

# Disable cloud-init
touch /etc/cloud/cloud-init.disabled
