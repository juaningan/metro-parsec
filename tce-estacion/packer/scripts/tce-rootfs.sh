#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
#bash -e -x ./mvi-noiso.sh -s 32bit ife debug realport motif fvwm tce xorg wget ssh
bash -e -x ./mvi-noiso.sh -s 32bit dhcp debug realport motif fvwm tce xorg wget ssh
