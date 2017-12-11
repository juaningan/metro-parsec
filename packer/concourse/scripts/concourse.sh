#!/bin/bash

set -e
set -x

apt-get update -y
apt-get install -y ca-certificates postgresql postgresql-contrib
service postgresql start
su postgres --command '\createuser -s -w concourse' 
su postgres --command '\createdb --owner=concourse concourse'

wget -q https://github.com/concourse/concourse/releases/download/v3.6.0/concourse_linux_amd64 -O /usr/local/bin/concourse
chmod +x /usr/local/bin/concourse
mkdir -p /etc/concourse
ssh-keygen -t rsa -f /etc/concourse/host_key -N ''
ssh-keygen -t rsa -f /etc/concourse/session_signing_key -N ''
ssh-keygen -t rsa -f /etc/concourse/worker_key -N ''

cp /etc/concourse/worker_key.pub /etc/concourse/authorized_worker_keys
adduser --system --group concourse
chgrp concourse /etc/concourse/*
chmod g+r /etc/concourse/*

echo 'all_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'http_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'https_proxy="http://16.0.96.20:3128"' >> /etc/environment

cat /etc/environment

cat > /etc/systemd/system/concourse_web.service << 'EOF'
[Unit]
Description=Concourse CI Web
After=postgres.service

[Service]
ExecStart=/usr/local/bin/concourse web \
	--basic-auth-username concourse \
	--basic-auth-password changeme  \
	--session-signing-key /etc/concourse/session_signing_key \
	--tsa-host-key /etc/concourse/host_key \
	--tsa-authorized-keys /etc/concourse/authorized_worker_keys \
	--external-url "http://127.0.0.1:8080" \
	--postgres-data-source 'postgres:///concourse?host=/var/run/postgresql'

User=concourse
Group=concourse

Type=simple
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF

cat /etc/systemd/system/concourse_web.service

cat > /etc/systemd/system/concourse_worker.service << 'EOF'
[Unit]
Description=Concourse CI Worker
After=concourse_web.service

[Service]
EnvironmentFile=/etc/environment
ExecStart=/usr/local/bin/concourse worker \
	--work-dir /var/lib/concourse \
	--tsa-host localhost \
	--tsa-public-key /etc/concourse/host_key.pub \
	--tsa-worker-private-key /etc/concourse/worker_key

User=root
Group=root

Type=simple
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF

cat /etc/systemd/system/concourse_worker.service

systemctl enable concourse_web.service
systemctl enable concourse_worker.service

sync
