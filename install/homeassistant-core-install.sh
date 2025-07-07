#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/thomaslarsen/Proxmox/raw/main/LICENSE

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies (Patience)"
$STD apt-get install -y git curl sudo mc bluez libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libopenjp2-7 libturbojpeg0-dev ffmpeg liblapack3 liblapack-dev dbus-broker libpcap-dev libavdevice-dev libavformat-dev libavcodec-dev libavutil-dev libavfilter-dev libmariadb-dev-compat libatlas-base-dev pip python3.12-dev
msg_ok "Installed Dependencies"

msg_info "Installing UV"
$STD pip install uv
msg_ok "Installed UV"

msg_info "Setting up Home Assistant-Core environment"
mkdir /srv/homeassistant
cd /srv/homeassistant
uv venv . &>/dev/null
source bin/activate
msg_ok "Created virtual environment with UV"

msg_info "Installing Home Assistant-Core and packages"
$STD uv pip install webrtcvad wheel homeassistant mysqlclient psycopg2-binary isal
mkdir -p /root/.homeassistant
msg_ok "Installed Home Assistant-Core and required packages"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/homeassistant.service
[Unit]
Description=Home Assistant
After=network-online.target
[Service]
Type=simple
WorkingDirectory=/root/.homeassistant
Environment="PATH=/srv/homeassistant/bin:/usr/local/bin:/usr/bin:/usr/local/bin/uv"
ExecStart=/srv/homeassistant/bin/python3 -m homeassistant --config /root/.homeassistant
Restart=always
RestartForceExitStatus=100
[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now homeassistant
msg_ok "Created Service"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
