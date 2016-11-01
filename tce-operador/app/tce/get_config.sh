#!/bin/bash

set -e
set -x

cd /tmp
wget --no-check-certificate --quiet "https://github.com/juaningan/operador-tce-config/archive/master.tar.gz"

tar -C /opt/sico/tce/sistema/V -xvzf master.tar.gz operador-tce-config-master/common/ --strip-components=2
tar -C /opt/sico/tce/sistema/V -xvzf master.tar.gz operador-tce-config-master/nodes/${HOSTNAME}/ --strip-components=3

rm -f master.tar.gz
