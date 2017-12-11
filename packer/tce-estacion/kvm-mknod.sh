#!/bin/bash
# If possible, create the /dev/kvm device node.

set -x
set -e

cat /proc/cpuinfo
lsmod | grep '\<kvm\>'
mknod /dev/kvm c 10 $(grep '\<kvm\>' /proc/misc | cut -f 1 -d' ')
kvm-ok

ls -l /dev/kvm

packer build tce-qemu.json
