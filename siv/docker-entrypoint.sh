#!/bin/bash
set -e
set -x

cp /siv/hosts /etc/hosts
cp /siv/services /etc/services

hostname sivodonell

/sbin/rpcbind -i
cd /siv/sistema/V
/siv/sun/control

