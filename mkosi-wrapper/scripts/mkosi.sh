#!/bin/bash
set -e
set -x

sed -i "s/DEBIAN_FRONTEND/http_proxy': 'http:\/\/16.0.96.20:3128', 'DEBIAN_FRONTEND/g" /usr/bin/mkosi
mkdir -p /tmp/output
mkdir -p /tmp/cache
mkosi --xz --cache=/tmp/cache --output-dir=/tmp/output/
