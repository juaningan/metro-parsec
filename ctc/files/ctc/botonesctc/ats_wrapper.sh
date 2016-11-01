#!/bin/bash
WID=$(xdotool search --name Firefox 2>/dev/null | tail -n 1)
MAP=$(xprop -id ${WID} 2>/dev/null | awk '/window state/ {print $3}')
if [ -z "${WID}" ]; then
  ESTADO='ausente'
elif [ "$MAP" == "Normal" ]; then
  ESTADO='visible'
else
  ESTADO='oculto'
fi

case "${ESTADO}" in
  ausente)
    /usr/bin/firefox -width 1270 -height 900 /opt/metro/botonesctc/autologin.html &
    WID=$(xdotool search --name --sync "Cliente WEB Bombardier"| tee >(zenity --progress --pulsate --auto-close --text="Abriendo ATS..."))
    sed -in "s/^ats_.*$/ats_${DISPLAY}/g" /var/tmp/APP
    sleep 2
    xdotool windowmove ${WID} 0 53
    ;;
  visible)
    killall firefox
    sed -in "s/^ats_.*$/ats_null/g" /var/tmp/APP
    ;;
  oculto)
    xdotool windowmap ${WID} 
    xdotool windowmove ${WID} 0 53
    ;;
esac

