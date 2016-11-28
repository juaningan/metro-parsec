#!/bin/bash

set -e
set -x

/usr/bin/ssh-keygen -A
cp /etc/ssh/* etc/ssh/
ln -sf /usr/bin/true usr/bin/ssh-keygen
