#!/bin/bash
WID=$(xdotool search --name "Regulador   Version 1.0" 2>/dev/null)
MAP=$(xprop -id ${WID} 2>/dev/null | awk '/window state/ {print $3}')
DIS=$(echo ${DISPLAY} | tail -c -2)
if [ -z "${WID}" ]; then
  ESTADO='ausente'
elif [ "$MAP" == "Normal" ]; then
  ESTADO='visible'
else
  ESTADO='oculto'
fi

case "${ESTADO}" in
  ausente)
    /usr/local/dimetronic/ATS/shells/lanzaMultiplexor.sh jboss4 MM &
    /usr/local/dimetronic/ATS/shells/lanzaIHMSirei.sh localhost:0.${DIS}  0 MM es_ES_EURO /usr/local/dimetronic/ATS/regulacion/sirei/ihm/historicos pg_7 &
    /usr/local/dimetronic/ATS/shells/lanzaHorariosDia pg_7 MM es_ES_EURO localhost:0.${DIS} &
    WID=$(xdotool search --name --sync "Regulador   Version 1.0"| tee >(zenity --progress --pulsate --auto-close --text="Abriendo Sirei..."))
    sed -in "s/^sir_.*$/sir_${DISPLAY}/g" /var/tmp/APP
    sleep 2
    xdotool windowmap ${WID} 
    xdotool windowsize ${WID} 1270 900
    xdotool windowmove ${WID} 0 53
    ;;
  visible)
    kill $(ps aux | awk  '/[s]irei/ {print $2}')
    sed -in "s/^sir_.*$/sir_null/g" /var/tmp/APP
    ;;
  oculto)
    xdotool windowmap ${WID} 
    xdotool windowsize ${WID} 1270 900
    xdotool windowmove ${WID} 0 53
    ;;
esac

