#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
#bash -e -x ./mvi-mkfs.sh -s 32bit dhcp-iprb wget tce-installer tce-drivers
bash -e -x ./mvi-mkfs.sh -s 32bit debug ife wget tce-installer
