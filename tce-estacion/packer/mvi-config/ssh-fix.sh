#!/bin/bash

set -e
set -x

/usr/bin/ssh-keygen -A
cp /etc/ssh/* etc/ssh/
