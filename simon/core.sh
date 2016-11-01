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

wget -q "https://labs.consol.de/repo/testing/RPM-GPG-KEY" -O - | apt-key add -
echo "deb http://labs.consol.de/repo/testing/ubuntu ${RELEASE} main" > /etc/apt/sources.list.d/labs-consol-stable.list

apt-get update -y

# Naemon core
apt-get install -y --no-install-recommends dma
apt-get install -y --no-install-recommends naemon-core naemon-tools
rm -rf /etc/init.d/naemon
cp -v /${PROVISION_DIR}/naemon/systemd/naemon.conf /usr/lib/tmpfiles.d/.
cp -v /${PROVISION_DIR}/naemon/systemd/naemon.service /usr/lib/systemd/system/.
cp -v /${PROVISION_DIR}/naemon/consul/naemon.json /etc/consul.d/.
rm -rf /etc/naemon/*.cfg
rm -rf /etc/naemon/conf.d
cp -rv /${PROVISION_DIR}/naemon/config/* /etc/naemon/.
mkdir -p /etc/naemon/module-conf.d
systemctl enable naemon.service

# Naemon livestatus
apt-get install -y --no-install-recommends naemon-livestatus
cp -v /${PROVISION_DIR}/naemon/systemd/proxy-to-livestatus.socket /usr/lib/systemd/system/.
cp -v /${PROVISION_DIR}/naemon/systemd/proxy-to-livestatus.service /usr/lib/systemd/system/.
sed -i 's/var\/cache/run/g' /etc/naemon/module-conf.d/livestatus.cfg

# Naemon status.dat server/client
apt-get install -y --no-install-recommends socat
cp -v /${PROVISION_DIR}/naemon/systemd/status-dat-server.socket /usr/lib/systemd/system/.
cp -v /${PROVISION_DIR}/naemon/systemd/status-dat-server@.service /usr/lib/systemd/system/.

# Mod-Gearman
apt-get install -y --no-install-recommends mod-gearman-module mod-gearman-tools
ln -s /usr/lib/x86_64-linux-gnu/libgearman.so.7 /usr/lib/x86_64-linux-gnu/libgearman.so.6
cp -v /${PROVISION_DIR}/mod-gearman/mod_gearman.cfg /etc/naemon/module-conf.d/.
cp -v /${PROVISION_DIR}/mod-gearman/module.conf /etc/mod-gearman/.
cp -v /${PROVISION_DIR}/mod-gearman/consul-template/mod-gearman.hcl /etc/consul-template.d/.
cp -v /${PROVISION_DIR}/mod-gearman/consul-template/module.conf.ctmpl /etc/consul-templates/.

# Gearmand
apt-get install -y --no-install-recommends gearman
cp -v /${PROVISION_DIR}/gearmand/consul/gearmand.json /etc/consul.d/.
rm -rf /etc/init.d/gearman-job-server
cp -v /${PROVISION_DIR}/gearmand/systemd/gearman-job-server.service /usr/lib/systemd/system/.

# Merlin
wget "http://16.0.96.20/repo/merlin.tar.gz" -O - | tar -xvz -C /
mv /etc/naemon/merlin.cfg /etc/naemon/module-conf.d/.
cp -v /${PROVISION_DIR}/merlin/systemd/merlind.service /usr/lib/systemd/system/.
cp -v /${PROVISION_DIR}/merlin/systemd/merlind.conf /usr/lib/tmpfiles.d/.
cp -v /${PROVISION_DIR}/merlin/merlin.conf /usr/local/etc/merlin/.
cp -v /${PROVISION_DIR}/merlin/consul-template/merlin.hcl /etc/consul-template.d/.
cp -v /${PROVISION_DIR}/merlin/consul-template/merlin.conf.ctmpl /etc/consul-templates/.
systemctl enable merlind.service
 
# Enable consul-template
systemctl enable consul-template.service

# Configure Network
cat > /etc/systemd/network/mv-${BRIDGE}.network <<NETWORK_CONF
[Match]
Name=mv-${BRIDGE}

[Network]
DHCP=yes
DNS=127.0.0.1
NETWORK_CONF

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

rm -rf ${PROVISION_DIR}

tar -czf "/tmp/simon-core.tar.gz" -C ${ROOT_DIR} .
cat > /tmp/simon-core.nspawn <<NSPAWN
[Exec]
Boot=true

[Network]
MACVLAN=eno1
NSPAWN

rm -rf ${ROOT_DIR}
