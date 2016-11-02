#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi-mkfs.sh -s 32bit dhcp tce-installer
