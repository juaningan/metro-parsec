#!/bin/bash

set -o -x -e

CONSUL_VERSION=1.0.1
HASHICORP_RELEASES=https://releases.hashicorp.com

adduser --system --group consul

apt-get install -y ca-certificates wget gnupg openssl unzip
#gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C

mkdir -p /tmp/build
cd /tmp/build

wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS
wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig

#gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS
grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c
unzip -d /bin consul_${CONSUL_VERSION}_linux_amd64.zip

cd /tmp
rm -rf /tmp/build
rm -rf ~/.gnupg

mkdir -p /consul/data
mkdir -p /consul/config
chown -R consul:consul /consul

cp -v /tmp/config/consul.service /etc/systemd/system/.
cp -v /tmp/config/consul_server.json /consul/config/.
systemctl daemon-reload
systemctl enable consul.service
rm -rf /tmp/config

sync
