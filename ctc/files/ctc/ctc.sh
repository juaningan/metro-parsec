#!/bin/bash

set -e
set -x

export CTCING=/opt/dimetronic
export CTCHIST=/home/opermm/historicos
export CTCEJEC=${CTCING}/ejecutables
export CTCCONFIG=${CTCING}/etc
export PATH=$PATH:$CTCEJEC/ws:$CTCEJEC/herramienta:$CTCEJEC/ws/shells:$CTCEJEC/herramienta/shells:$CTCEJEC/moviola:$CTCEJEC/moviola/shells
export XAPPLRESDIR=$CTCEJEC/ws/config/app-defaults

xset fp+ ${CTCING}/fonts
xset fp rehash

# CTC
 /opt/dimetronic/ejecutables/ws/shells/arranqueWS -mm -1 -usuario OPERADOR -nivel 1 -24Planos -display :0.0

# Botones CTC y enrutador
/bin/cp -rf /opt/metro/botonesctc/APP /var/tmp/APP
ruby /opt/metro/botonesctc/autogrid.rb &
