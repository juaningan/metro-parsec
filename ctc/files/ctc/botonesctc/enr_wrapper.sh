#!/bin/bash
WID=$(xdotool search --name --onlyvisible "^Enrutador$" 2>/dev/null)
DIS=$(echo ${DISPLAY} | tail -c -2)

if [ -f /usr/local/dimetronic/ATS/regulacion/enrutador/shells/lanzaInterfazEnrutador ]; then
if [ -z "${WID}" ]; then
  if ps -eaf | grep en[r]utador; then
    ESTADO='oculto'
  else
    ESTADO='ausente'
  fi
else
  ESTADO='visible'
fi

case "${ESTADO}" in
  oculto)
    WID=$(xdotool search --name "^Enrutador$")
    sed -in "s/^enr_.*$/enr_${DISPLAY}/g" /var/tmp/APP
    xdotool windowmap ${WID} 
    xdotool windowsize ${WID} 1270 900
    ;;
  visible)
    touch /usr/local/dimetronic/ATS/PararInterfazEnrutador.`hostname`
    kill $(ps aux | awk  '/[e]nrutador/ {print $2}')
    sed -in "s/^enr_.*$/enr_null/g" /var/tmp/APP
    ;;
  ausente)
    /usr/local/dimetronic/ATS/regulacion/enrutador/shells/lanzaInterfazEnrutador jboss4 pg_7 localhost:0.${DIS} MM /usr/local/dimetronic/AppJava/Enrutador/InterfazEnrutador es_ES_EURO &
    WID=$(xdotool search --name --sync "^Enrutador$"| tee >(zenity --progress --pulsate --auto-close --text="Abriendo Enrutador..."))
    sed -in "s/^enr_.*$/enr_${DISPLAY}/g" /var/tmp/APP
    xdotool windowmap ${WID}
    xdotool windowsize ${WID} 1270 900
    ;;
esac
fi
