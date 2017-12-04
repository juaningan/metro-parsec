#!/bin/bash 

set -eux


DNF_CMD="dnf -y --best --allowerasing --setopt=keepcache=1 --setopt=install_weak_deps=0 --setopt=tsflags=nodocs"

# Install dependencies
${DNF_CMD} install \
  arch-install-scripts \
  btrfs-progs \
  debootstrap \
  dosfstools \
  e2fsprogs \
  edk2-ovmf \
  git \
  squashfs-tools \
  gnupg \
  python3 \
  systemd-container \
  tar \
  util-linux-user \
  veritysetup \
  xz \
  zypper

# Install mkosi
git clone https://github.com/systemd/mkosi.git /tmp/mkosi \
  && cd /tmp/mkosi \
  && python3 ./setup.py install
