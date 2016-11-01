#!/bin/bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

DIMETRONIC_PATH=/opt/dimetronic
METRO_PATH=/opt/metro

mkdir -p ${DIMETRONIC_PATH}
mkdir -p ${METRO_PATH}

ln -sf /opt /usr/local

cd /tmp
mv files/ctc/fonts ${DIMETRONIC_PATH}/
mv files/ctc/ctc.sh /root/

mkdir -p /home/opermm/.ssh
cat files/ctc/keys/* >> /home/opermm/.ssh/authorized_keys
chown -R opermm:ctcing /home/opermm/.ssh
chmod 0700 /home/opermm/.ssh
chmod 0600 /home/opermm/.ssh/authorized_keys

wget --quiet http://16.0.96.20/repo/rail9000-MetroMadrid-Puesto-4.0.tar.gz
tar xzf rail9000-MetroMadrid-Puesto-4.0.tar.gz -C ${DIMETRONIC_PATH}

wget --quiet http://16.0.96.20/repo/rail9000-MetroMadrid-ihmTN-1.0.tar.gz
tar xzf rail9000-MetroMadrid-ihmTN-1.0.tar.gz -C ${DIMETRONIC_PATH}

wget --quiet http://16.0.96.20/repo/rail9000-ATS-REG.tar.gz
tar xzf rail9000-ATS-REG.tar.gz -C ${DIMETRONIC_PATH}

# Botones
cp -r /tmp/files/ctc/botonesctc ${METRO_PATH}

# Postinst script extracted from rpm rail9000-MetroMadrid-Puesto-4.0
# Directorio de los historicos y permisos
#mkdir -p ${DIMETRONIC_PATH}/historicos
mkdir -p ${DIMETRONIC_PATH}/InterfazEnrutador
#mkdir -p ${DIMETRONIC_PATH}/historicos/ws
mkdir -p /home/opermm/historicos/ws
#mkdir -p ${DIMETRONIC_PATH}/historicos/sirat
#mkdir -p ${DIMETRONIC_PATH}/historicos/sirat/{conf,bin,dat,horarios,informes,log}
mkdir -p /home/opermm/historicos/sirat/{conf,bin,dat,horarios,informes,log}
chown -R opermm:ctcing /home/opermm

if [ ! -d ${DIMETRONIC_PATH}/ejecutables/ws/colas_ws ]; then mkdir -p ${DIMETRONIC_PATH}/ejecutables/ws/colas_ws; fi

for i in `cat ${DIMETRONIC_PATH}/tmp/FichColasWs`
do
	if [ ! -f ${DIMETRONIC_PATH}/ejecutables/ws/colas_ws/$i ]
	then
		touch ${DIMETRONIC_PATH}/ejecutables/ws/colas_ws/$i
	fi
done

chmod -R 755 ${DIMETRONIC_PATH}/ejecutables/ws
#chown -R opermm:ctcing ${DIMETRONIC_PATH}/ejecutables/ws
#chmod -R 755 ${DIMETRONIC_PATH}/historicos
chmod -R 755 /home/opermm/historicos
#chown -R opermm:ctcing ${DIMETRONIC_PATH}/historicos
chmod -R 755 ${DIMETRONIC_PATH}/InterfazEnrutador
# End of postinst

# Postinst script extracted from rpm rail9000-MetroMadrid-Puesto-4.0
# Directorio de los datos e historicos y permisos
chmod -R 755 ${DIMETRONIC_PATH}/datos/herramienta
chmod -R 755 ${DIMETRONIC_PATH}/etc/herramienta
#chown -R opermm:ctcing ${DIMETRONIC_PATH}/datos ${DIMETRONIC_PATH}/etc
if [ ! -h ${DIMETRONIC_PATH}/datos/ws ]
	then
		ln -s ${DIMETRONIC_PATH}/datos/herramienta ${DIMETRONIC_PATH}/datos/ws
fi

if [ ! -h ${DIMETRONIC_PATH}/datos/server ]
	then
		ln -s ${DIMETRONIC_PATH}/datos/herramienta ${DIMETRONIC_PATH}/datos/server
fi

if [ ! -h ${DIMETRONIC_PATH}/datos/moviola ]
	then
		ln -s ${DIMETRONIC_PATH}/datos/herramienta ${DIMETRONIC_PATH}/datos/moviola
fi

if [ ! -h ${DIMETRONIC_PATH}/etc/ws ]
	then
		ln -s ${DIMETRONIC_PATH}/etc/herramienta ${DIMETRONIC_PATH}/etc/ws
	fi
if [ ! -h ${DIMETRONIC_PATH}/etc/server ]
	then
		ln -s ${DIMETRONIC_PATH}/etc/herramienta ${DIMETRONIC_PATH}/etc/server
fi

if [ ! -h ${DIMETRONIC_PATH}/etc/moviola ]
	then
		ln -s ${DIMETRONIC_PATH}/etc/herramienta ${DIMETRONIC_PATH}/etc/moviola
fi
# End of postinst script

# Postinst script extracted from rpm rail9000-MetroMadrid-Puesto-4.0
# Directorio de los datos e historicos y permisos
chmod -R 755 ${DIMETRONIC_PATH}/etc/herramienta
#chown -R opermm:ctcing ${DIMETRONIC_PATH}/etc

if [ ! -h ${DIMETRONIC_PATH}/etc/ws ]
	then
		ln -s ${DIMETRONIC_PATH}/etc/herramienta ${DIMETRONIC_PATH}/etc/ws
	fi
if [ ! -h ${DIMETRONIC_PATH}/etc/server ]
	then
		ln -s ${DIMETRONIC_PATH}/etc/herramienta ${DIMETRONIC_PATH}/etc/server
fi

if [ ! -h ${DIMETRONIC_PATH}/etc/moviola ]
	then
		ln -s ${DIMETRONIC_PATH}/etc/herramienta ${DIMETRONIC_PATH}/etc/moviola
fi
# End of postinst script

