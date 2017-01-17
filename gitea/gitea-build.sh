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

cp ${SCRIPT_DIR}/gitea-setup.sh usr/local/bin/
chmod +x usr/local/bin/gitea-setup.sh

cp ${SCRIPT_DIR}/gitea.service usr/lib/systemd/system/gitea.service
systemd-nspawn -D ${ROOT_DIR} systemctl enable gitea.service

mkdir etc/gitea
cp ${SCRIPT_DIR}/app.ini etc/gitea/

cat > init-setup.sh <<SETUP
#!/usr/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

# Disable consul
systemctl disable consul.service

# Install gitea
apt-get install -y --no-install-recommends git
adduser --system --group --disabled-login git

wget "https://dl.gitea.io/gitea/1.0.1/gitea-1.0.1-linux-amd64" -O /usr/local/bin/gitea
chmod +x /usr/local/bin/gitea

mkdir /srv/gitea
chown -R git:git /srv/gitea

# Enable network
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

tar -czf "/tmp/gitea.tar.gz" -C ${ROOT_DIR} .
rm -rf ${ROOT_DIR}
