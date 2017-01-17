#!/bin/bash

mkdir -p /srv/gitea/conf
mkdir -p /srv/gitea/log

if [ ! -f /srv/gitea/conf/app.ini ]; then
    mkdir -p /srv/gitea/conf
    cp /etc/gitea/app.ini /srv/gitea/conf/app.ini
fi
