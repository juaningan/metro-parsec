#!/bin/bash

set -e
set -x

if [ $(id -u) -ne 0 ]; then
  echo "You must be root to run this script"
  exit 1
fi

SCRIPT_DIR=$PWD
ROOT_DIR=$(mktemp -d)
BRIDGE=eno1
RELEASE=xenial
PROVISION_DIR=provision

# OS stage
# Install prerequisites
apt-get update
apt-get install -y debootstrap squashfs-tools xz-utils wget systemd-container

cd ${ROOT_DIR}

export no_proxy="16.0.96.20"                                                                                                                                                                                        
wget "http://16.0.96.20/repo/ubuntu-amd64-xenial.tar.gz" -O - | tar xz -C ${ROOT_DIR}
mkdir -p provision
cp -vr ${SCRIPT_DIR}/* ${PROVISION_DIR}/.

cat > init-setup.sh <<SETUP
#!/usr/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

wget -q "https://labs.consol.de/repo/stable/RPM-GPG-KEY" -O - | apt-key add -
echo "deb http://labs.consol.de/repo/stable/ubuntu ${RELEASE} main" > /etc/apt/sources.list.d/labs-consol-stable.list

apt-get update -y

# Merlin build
groupadd -g 107 naemon
useradd -u 106 -g 107 --system naemon
/${PROVISION_DIR}/merlin/merlin.sh

apt-get -y autoremove
apt-get -y clean

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
rm -rf {var,tmp,dev,media,mnt,proc,run,sys}

rm -rf ${PROVISION_DIR}
tar -czf "/tmp/merlin.tar.gz" -C ${ROOT_DIR} .

rm -rf ${ROOT_DIR}

#systemd-nspawn --directory /var/lib/machines/tce-ubuntu-i386-16.04 --ephemeral --machine=op30 --network-macvlan=eth0 --boot --capability=all
