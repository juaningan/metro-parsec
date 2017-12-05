#!/bin/bash
set -e
set -x

cd /tmp/mkosi
sed -i "s/DEBIAN_FRONTEND/http_proxy': 'http:\/\/16.0.96.20:3128', 'DEBIAN_FRONTEND/g" mkosi
./mkosi -C /tmp/files --output-dir=/tmp/output/
