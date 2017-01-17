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
ARCH=amd64

# OS stage
# Install prerequisites
apt-get update
apt-get install -y debootstrap squashfs-tools xz-utils wget systemd-container

cd ${ROOT_DIR}
export no_proxy="16.0.96.20"
debootstrap --arch=${ARCH} --variant=minbase --components=main,universe --include=usrmerge,dbus,wget,netbase,iproute2,iputils-ping,vim-nox --exclude=sysv-rc,initscripts,startpar,insserv ${RELEASE} ${ROOT_DIR} http://16.0.96.20:3142/archive.ubuntu.com/ubuntu

# Install setup-network-environment
wget -N -P usr/local/bin https://github.com/kelseyhightower/setup-network-environment/releases/download/1.0.1/setup-network-environment
chmod 0755 usr/local/bin/setup-network-environment
cat > usr/lib/systemd/system/setup-network-environment.service <<NETWORK_ENV
[Unit]
Description=Setup Network Environment
Documentation=https://github.com/kelseyhightower/setup-network-environment
Requires=systemd-networkd-wait-online.service
After=systemd-networkd-wait-online.service

[Service]
ExecStart=/usr/local/bin/setup-network-environment
RemainAfterExit=yes
Type=oneshot
NETWORK_ENV

# Install Consul
CONSUL_VERSION='0.7.2'
wget "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${ARCH}.zip" -O consul.zip
unzip consul.zip -d usr/local/bin
rm -f consul.zip
chmod 0755 usr/local/bin/consul
chown root:root usr/local/bin/consul

# Configure Consul
mkdir -p etc/consul.d
chmod 0755 etc/consul.d
cp -v ${SCRIPT_DIR}/consul/default.json etc/consul.d/.
cp -v ${SCRIPT_DIR}/consul/consul.service usr/lib/systemd/system/.
systemd-nspawn -D ${ROOT_DIR} systemctl enable consul.service

# Install consul-template
CONSULTEMPLATE_VERSION='0.18.0-rc2'
wget "https://releases.hashicorp.com/consul-template/${CONSULTEMPLATE_VERSION}/consul-template_${CONSULTEMPLATE_VERSION}_linux_${ARCH}.zip" -O consul-template.zip
unzip consul-template.zip -d usr/local/bin
rm -f consul-template.zip
chmod 0755 usr/local/bin/consul-template
chown root:root usr/local/bin/consul-template

# Configure consul-template
mkdir -p etc/consul-template.d
mkdir -p etc/consul-templates
chmod 0755 etc/consul-template.d
chmod 0755 etc/consul-templates
cp -v ${SCRIPT_DIR}/consul-template/consul-template.service usr/lib/systemd/system/.

# Workaround bug #1616939
echo "d /var/lib/dbus 0755 - - -" >> lib/tmpfiles.d/dbus.conf

systemd-nspawn -D ${ROOT_DIR} apt-get -y autoremove
systemd-nspawn -D ${ROOT_DIR} apt-get -y clean

rm -rf usr/share/locale
rm -rf usr/share/man
rm -rf usr/share/info
rm -rf usr/share/doc
rm -rf etc/hostname

#tar -cJf "/tmp/tce-ubuntu-${ARCH}-16.04.tar.xz" -C ${ROOT_DIR} .
tar -czf "/tmp/ubuntu-${ARCH}-${RELEASE}.tar.gz" -C ${ROOT_DIR} .

rm -rf ${ROOT_DIR}
