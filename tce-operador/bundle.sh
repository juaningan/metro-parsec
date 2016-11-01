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

# OS stage
# Install prerequisites
apt-get update
apt-get install -y debootstrap squashfs-tools xz-utils wget systemd-container

cd ${ROOT_DIR}
export no_proxy="16.0.96.20"
debootstrap --arch=i386 --variant=minbase --components=main,universe --include=usrmerge,dbus,wget,netbase,iproute2,iputils-ping,vim-nox --exclude=sysv-rc,initscripts,startpar,insserv xenial ${ROOT_DIR} http://16.0.96.20:3142/archive.ubuntu.com/ubuntu

# Copy files
cp -v ${SCRIPT_DIR}/files/hosts etc/
cp -v ${SCRIPT_DIR}/files/services etc/
cp -v ${SCRIPT_DIR}/files/systemd/*.service usr/lib/systemd/system/
cp -v ${SCRIPT_DIR}/files/systemd/*.socket usr/lib/systemd/system/
cp -v ${SCRIPT_DIR}/files/systemd/sico.conf usr/lib/tmpfiles.d/
mkdir -p opt/sico
cp -vr ${SCRIPT_DIR}/app/* opt/sico/

# Copy keys
mkdir -p home/opermm/.ssh
cat ${SCRIPT_DIR}/files/keys/* >> home/opermm/.ssh/authorized_keys

# Install setup-network-environment
wget -N -P usr/local/bin https://github.com/kelseyhightower/setup-network-environment/releases/download/1.0.1/setup-network-environment
chmod 0755 usr/local/bin/setup-network-environment
cat > usr/lib/systemd/system/setup-network-environment.service <<NETWORK_ENV
[Unit]
Description=Setup Network Environment
Documentation=https://github.com/kelseyhightower/setup-network-environment
Requires=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/local/bin/setup-network-environment
RemainAfterExit=yes
Type=oneshot
NETWORK_ENV

# Install Consul
wget "https://releases.hashicorp.com/consul/0.7.0-rc1/consul_0.7.0-rc1_linux_amd64.zip" -O consul.zip
unzip consul.zip -d usr/local/bin
rm -f consul.zip
chmod 0755 usr/local/bin/consul
chown root:root usr/local/bin/consul

# Configure Consul
mkdir -p etc/consul.d
chmod 0755 etc/consul.d
cp ${SCRIPT_DIR}/files/consul/*.json etc/consul.d/.
cp ${SCRIPT_DIR}/files/consul/consul.service usr/lib/systemd/system/.
systemd-nspawn -D ${ROOT_DIR} systemctl enable consul.service

cat > init-setup.sh <<SETUP
#!/usr/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

apt-get update -y

# X11 - WM - x11vnc
apt-get install -y --no-install-recommends xserver-xorg xinit x11-xserver-utils xserver-xorg-video-dummy xserver-xorg-input-void fvwm x11vnc xfonts-base xfonts-75dpi
 
# TCE
apt-get install -y --no-install-recommends openssh-server rpcbind
apt-get install -y --no-install-recommends libice6 libmrm4 libsm6 libx11-6 libxau6 libxdmcp6 libxext6 libxm4 libxmu6 libxpm4 libxt6 libncurses5 xviewg

wget --no-check-certificate --quiet https://launchpad.net/ubuntu/+archive/primary/+files/libxp6_1.0.2-2_i386.deb -O /tmp/libxp6_1.0.2-2_i386.deb
dpkg --install /tmp/libxp6_1.0.2-2_i386.deb

ln --symbolic --force libncurses.so.5 /usr/lib/i386-linux-gnu/libncurses.so.4

# Enable APP services
systemctl enable x11vnc-0.socket
systemctl enable x11vnc-1.socket
systemctl enable x11vnc-2.socket
systemctl enable x11vnc-3.socket
systemctl enable tce

# Configure Network
cat > /etc/systemd/network/mv-${BRIDGE}.network <<NETWORK_CONF
[Match]
Name=mv-${BRIDGE}

[Network]
DHCP=yes
NETWORK_CONF

ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl enable systemd-networkd.service systemd-resolved.service

# Configure users and SSH keys
groupadd ctcing --gid 501
useradd --uid 502 --gid 501 --shell /bin/bash --home-dir /home/opermm --create-home opermm
chown -R opermm:ctcing /home/opermm/.ssh
chmod 0700 /home/opermm/.ssh
chmod 0600 /home/opermm/.ssh/authorized_keys

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


#tar -cJf "/tmp/tce-ubuntu-i386-16.04.tar.xz" -C ${ROOT_DIR} .
tar -czf "/tmp/tce-ubuntu-i386-16.04.tar.gz" -C ${ROOT_DIR} .

rm -rf ${ROOT_DIR}

#systemd-nspawn --directory /var/lib/machines/tce-ubuntu-i386-16.04 --ephemeral --machine=op30 --network-macvlan=eth0 --boot --capability=all
