#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi-mkfs.sh -s 32bit wget ife xorg ssh vim tce-libs tce-setup realport tce-launch
