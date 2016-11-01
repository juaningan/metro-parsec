#!/bin/bash

set -e
set -x

cd /tmp
mv files/hosts /etc/hosts
mv files/services /etc/services
