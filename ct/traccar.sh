#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/thomaslarsen/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/thomaslarsen/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
  ______
 /_  __/________ _______________ ______
  / / / ___/ __ `/ ___/ ___/ __ `/ ___/
 / / / /  / /_/ / /__/ /__/ /_/ / /
/_/ /_/   \__,_/\___/\___/\__,_/_/

EOF
}
header_info
echo -e "Loading..."
APP="Traccar"
var_disk="2"
var_cpu="1"
var_ram="1024"
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
if [[ ! -d /opt/traccar ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_error "There is currently no update path available."
exit
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:8082${CL} \n"
