#!/bin/bash
WID=$(xdotool search --name "Gestion de los trabajos nocturnos" 2>/dev/null)
DIS=$(echo ${DISPLAY} | tail -c -2)

if [ -z "${WID}" ]; then
  ESTADO='ausente'
else
  ESTADO='visible'
fi

case "${ESTADO}" in
  ausente)
    /usr/local/dimetronic/MetroMadrid/trabajosNocturnos/ihm/shells/lanzaIHM.sh jboss4 pg_7 ${DIS} INSPECTOR &
    WID=$(xdotool search --name --sync "Gestion de los trabajos nocturnos"| tee >(zenity --progress --pulsate --auto-close --text="Abriendo Gestor de Trabajos Nocturnos..."))
    #WID=$(xdotool search --name --sync "Gestion de los trabajos nocturnos")
    sed -in "s/^tra_.*$/tra_${DISPLAY}/g" /var/tmp/APP
    sleep 2
    xdotool windowmap ${WID} 
    xdotool windowsize ${WID} 1270 900
    xdotool windowmove ${WID} 0 53
    ;;
  visible)
    kill $(ps aux | awk  '/trabajos[N]octurnos/ {print $2}')
    sed -in "s/^tra_.*$/tra_null/g" /var/tmp/APP
    ;;
esac

