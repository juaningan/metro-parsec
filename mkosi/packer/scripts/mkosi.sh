#!/bin/bash -eux

# Install dependencies
dnf install -y \
  arch-install-scripts \
  btrfs-progs \
  debootstrap \
  dosfstools \
  edk2-ovmf \
  git \
  squashfs-tools \
  gnupg \
  python3 \
  tar \
  util-linux-user \
  veritysetup \
  xz \
  zypper

# Install mkosi
git clone https://github.com/systemd/mkosi.git /tmp/mkosi \
  && cd /tmp/mkosi \
  && ./setup.py install
