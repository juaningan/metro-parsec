#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
#bash -e -x ./mvi-mkfs.sh -s 32bit debug dhcp wget tce-to-disk realport fvwm tce xorg ssh
bash -e -x ./mvi-mkfs.sh -s 32bit debug dhcp wget tce-to-disk
