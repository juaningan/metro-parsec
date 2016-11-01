#!/usr/bin/bash

set -x
set -e

apt-get install -y naemon-dev check gperf dh-autoreconf git
git clone https://github.com/op5/merlin.git
cd merlin
. ./autogen.sh --disable-auto-postinstall --disable-libdbi
make
make install
