#!/usr/bin/env bash

source <(curl -s https://raw.githubusercontent.com/thomaslarsen/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/thomaslarsen/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   _____                 __        ____  _
  / ___/____ ___  ____  / /_____  / __ \(_)___  ____ _
  \__ \/ __ `__ \/ __ \/ //_/ _ \/ /_/ / / __ \/ __ `/
 ___/ / / / / / / /_/ / ,< /  __/ ____/ / / / / /_/ /
/____/_/ /_/ /_/\____/_/|_|\___/_/   /_/_/ /_/\__, /
                                             /____/
EOF
}
header_info
echo -e "Loading..."
APP="SmokePing"
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
if ! command -v smokeping &> /dev/null; then msg_error "No ${APP} Installation Found!"; exit; fi

msg_info "Updating ${APP}"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}/smokeping${CL} \n"
