#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/thomaslarsen/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/thomaslarsen/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ________              _           ___    ____
   / ____/ /___ _      __(_)_______  /   |  /  _/
  / /_  / / __ \ | /| / / / ___/ _ \/ /| |  / /
 / __/ / / /_/ / |/ |/ / (__  )  __/ ___ |_/ /
/_/   /_/\____/|__/|__/_/____/\___/_/  |_/___/

EOF
}
header_info
echo -e "Loading..."
APP="FlowiseAI"
var_disk="10"
var_cpu="4"
var_ram="4096"
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
if [[ ! -f /etc/systemd/system/flowise.service ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
whiptail --backtitle "Proxmox VE Helper Scripts" --msgbox --title "SET RESOURCES" "Please set the resources in your ${APP} LXC to ${var_cpu}vCPU and ${var_ram}RAM for the build process before continuing" 10 75
msg_info "Updating ${APP}"
systemctl stop flowise
npm install -g flowise --upgrade
systemctl start flowise
msg_ok "Updated ${APP}"
exit
}

start
build_container
description

msg_info "Setting Container to Normal Resources"
pct set $CTID -memory 2048
pct set $CTID -cores 2
msg_ok "Set Container to Normal Resources"
msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:3000${CL} \n"
