#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/thomaslarsen/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/thomaslarsen/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    __  ___      __  _
   /  |/  /___  / /_(_)___  ____  ___  __  _____
  / /|_/ / __ \/ __/ / __ \/ __ \/ _ \/ / / / _ \
 / /  / / /_/ / /_/ / /_/ / / / /  __/ /_/ /  __/
/_/  /_/\____/\__/_/\____/_/ /_/\___/\__, /\___/
                                    /____/
EOF
}
header_info
echo -e "Loading..."
APP="Motioneye"
var_disk="8"
var_cpu="2"
var_ram="2048"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/systemd/system/motioneye.service ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
pip install motioneye --upgrade &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:8765${CL} \n"
