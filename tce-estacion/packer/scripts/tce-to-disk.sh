#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi-mkfs.sh -s 32bit wget xorg ssh nfs tce-libs tce-setup realport smf usr-lgz debug
