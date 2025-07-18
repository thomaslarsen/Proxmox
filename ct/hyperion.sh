#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/thomaslarsen/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/thomaslarsen/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    __  __                      _
   / / / /_  ______  ___  _____(_)___  ____
  / /_/ / / / / __ \/ _ \/ ___/ / __ \/ __ \
 / __  / /_/ / /_/ /  __/ /  / / /_/ / / / /
/_/ /_/\__, / .___/\___/_/  /_/\____/_/ /_/
      /____/_/

EOF
}
header_info
echo -e "Loading..."
APP="Hyperion"
var_disk="2"
var_cpu="1"
var_ram="512"
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
if [[ ! -f /etc/apt/sources.list.d/hyperion.list ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get install -y hyperion &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:8090${CL} \n"
