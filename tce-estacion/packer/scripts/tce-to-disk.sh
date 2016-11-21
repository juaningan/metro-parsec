#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi-mkfs.sh -s 32bit wget ife fvwm xorg ssh tce-libs tce-setup realport tce-launch
