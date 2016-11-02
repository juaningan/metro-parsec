#!/bin/bash

set -x
set -e

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi-noiso.sh -s 32bit dhcp debug realport motif tce xorg
