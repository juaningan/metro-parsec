#!/bin/bash

set -e
set -x

if [ $(id -u) -ne 0 ]; then
  echo "You must be root to run this script"
  exit 1
fi
SCRIPT_DIR=$PWD
ROOT_DIR=$(mktemp -d)
RELEASE=yakkety

# OS stage
# Install prerequisites
apt-get update
apt-get install -y debootstrap squashfs-tools xz-utils wget systemd-container

cd ${ROOT_DIR}

export no_proxy="16.0.96.20"                                                                                                                                                                                        
wget "http://16.0.96.20/repo/ubuntu-amd64-${RELEASE}.tar.gz" -O - | tar xz -C ${ROOT_DIR}

cp ${SCRIPT_DIR}/systemd/crp.service ${SCRIPT_DIR}/systemd/crp-network.service usr/lib/systemd/system/
systemd-nspawn -D ${ROOT_DIR} systemctl enable crp.service crp-network.service
mkdir -p ${ROOT_DIR}/srv/crp/systemd/network
cp ${SCRIPT_DIR}/systemd/network/* ${ROOT_DIR}/srv/crp/systemd/network/

cat > init-setup.sh <<SETUP
#!/usr/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

# Disable consul
systemctl disable consul.service

# Install CRP
apt-get install -y --no-install-recommends lib32z1 libc6-i386
adduser --system --group --disabled-login crp

wget "http://16.0.96.20/repo/crp_main" -O /usr/local/bin/crp_main
chmod +x /usr/local/bin/crp_main

chown -R crp:crp /srv/crp

# Configure Network
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl enable systemd-networkd.service systemd-resolved.service

apt-get -y autoremove
apt-get -y clean
apt-get purge -y --allow-remove-essential apt

SETUP
chmod +x init-setup.sh
systemd-nspawn -D ${ROOT_DIR}\
 --setenv=http_proxy=$http_proxy\
 --setenv=https_proxy=$https_proxy\
 --setenv=no_proxy=$no_proxy\
 /init-setup.sh
rm init-setup.sh

# Clean
rm -rf usr/share/locale
rm -rf usr/share/man
rm -rf usr/share/info
rm -rf usr/share/doc
rm -rf etc/hostname
rm -rf etc/apt
rm -rf {var,tmp,dev,media,mnt,proc,run,sys}

tar -czf "/tmp/crp.tar.gz" -C ${ROOT_DIR} .
rm -rf ${ROOT_DIR}
