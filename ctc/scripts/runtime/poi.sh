#!/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

apt-get update --quiet --quiet
apt-get install --assume-yes --no-install-recommends usrmerge
#apt-get install --assume-yes --no-install-recommends xserver-xorg-core x11-xserver-utils x11-utils xinit xterm fvwm mwm
#apt-get install --assume-yes --no-install-recommends xfonts-base xfonts-75dpi
#apt-get install --assume-yes --no-install-recommends zenity xdotool swaks
#apt-get install --assume-yes --no-install-recommends libtcltk-ruby
#apt-get install --assume-yes --no-install-recommends firefox
#apt-get install --assume-yes --no-install-recommends openjdk-8-jre-headless
apt-get install --assume-yes --no-install-recommends nfs-common
apt-get install --assume-yes --no-install-recommends systemd-container

# para pruebas vbox
#apt-get install --assume-yes --no-install-recommends virtualbox-guest-x11 xserver-xorg-input-all

dpkg --add-architecture i386                                                                                                                
apt-get update --quiet --quiet                                                                                                              
apt-get install --assume-yes --no-install-recommends libc6:i386 libice6:i386 libmrm4:i386 libsm6:i386 libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxm4:i386 libxmu6:i386 libxpm4:i386 libxt6:i386 libncurses5:i386 xviewg:i386

cd /tmp                                                                                                                                     
wget --quiet http://old-releases.ubuntu.com/ubuntu/pool/universe/x/xpostit/xpostit_3.3.1-9_amd64.deb
dpkg --install xpostit_3.3.1-9_amd64.deb

wget --quiet https://launchpad.net/ubuntu/+archive/primary/+files/libxp6_1.0.2-2_i386.deb
dpkg --install libxp6_1.0.2-2_i386.deb

ln --symbolic --force libncurses.so.5 /usr/lib/i386-linux-gnu/libncurses.so.4
mkdir --parents /usr/X11R6
ln --symbolic --force /usr/bin /usr/X11R6/bin

#cp files/xinitrc /root/.xinitrc
#cp files/xresources /root/.xresources
#cp files/xserverrc /root/.xserverrc
#mkdir --parents /root/.fvwm
#cp files/config* /root/.fvwm/
#cp files/xorg* /root/

groupadd ctcing --gid 501
useradd --uid 502 --gid 501 --shell /bin/bash --home-dir /home/opermm --create-home opermm

# Cleaning (from bento project)

# Delete all Linux headers
dpkg --list \
  | awk '{ print $2 }' \
  | grep 'linux-headers' \
  | xargs apt-get -y purge;

# Remove specific Linux kernels, such as linux-image-3.11.0-15-generic but
# keeps the current kernel and does not touch the virtual packages,
# e.g. 'linux-image-generic', etc.
dpkg --list \
    | awk '{ print $2 }' \
    | grep 'linux-image-3.*-generic' \
    | grep -v `uname -r` \
    | xargs apt-get -y purge;

# Delete Linux source
dpkg --list \
    | awk '{ print $2 }' \
    | grep linux-source \
    | xargs apt-get -y purge;

# Delete development packages
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-dev$' \
    | xargs apt-get -y purge;

# Delete obsolete networking
apt-get -y purge ppp pppconfig pppoeconf;

# Delete oddities
apt-get -y purge popularity-contest;

apt-get -y autoremove;
apt-get -y clean;
