#!/bin/bash

set -x
set -e

RELEASE='master'

# Prepare zap
mkdir -p /tmp/zap/cache
rm -rf /var/zap/cache
ln -sf /tmp/zap/cache /var/zap/cache
zap refresh

# Install GNU tar
zap install -R /tmp TRIBarchiver-gnu-tar

# Download mvi
mkdir -p /packages/localsrc/Tribblix/mvi
wget  "https://github.com/juaningan/mvi/archive/${RELEASE}.tar.gz" -O /tmp/mvi.tar.gz
/tmp/usr/bin/gtar xvzf /tmp/mvi.tar.gz -C /packages/localsrc/Tribblix/mvi/ --strip 1

# Download mvi
wget  "https://github.com/juaningan/metro-parsec/archive/${RELEASE}.tar.gz" -O /tmp/metro-parsec.tar.gz
/tmp/usr/bin/gtar xvzf /tmp/metro-parsec.tar.gz -C /packages/localsrc/Tribblix/mvi/ --strip 3 metro-parsec-${RELEASE}/tce-estacion/mvi-custom

# Run mvi
cd /packages/localsrc/Tribblix/mvi/
bash -e -x ./mvi.sh -s 32bit
ls -l
