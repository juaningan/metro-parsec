#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi-mkfs.sh -s 32bit debug wget ife xorg ssh vim nfs tce-libs tce-setup realport smf
