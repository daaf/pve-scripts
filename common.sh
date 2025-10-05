#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# color codes
RD=$'\e[01;31m'
YW=$'\e[33m'
GN=$'\e[1;92m'
CL=$'\e[0m'

# Disable colors if not running on a TTY
if [[ ! -t 1 ]]; then RD=""; YW=""; GN=""; CL=""; BFR=""; CM="OK"; CROSS="X"; fi

# chars
BFR=$'\r\e[K'
HOLD='-'
CM="${GN}✓${CL}"
CROSS="${RD}✗${CL}"

# output types
msg_info() {
  local msg="$1"
  echo -ne " ${HOLD} ${YW}${msg}...${CL}"
}

msg_ok() {
  local msg="$1"
  echo -e "${BFR} ${CM} ${GN}${msg}${CL}"
}

msg_error() {
  local msg="$1"
  echo -e "${BFR} ${CROSS} ${RD}${msg}${CL}"
}

set -Eeuo pipefail

trap 'msg_error "Unexpected failure running: \"$BASH_COMMAND\" (line $LINENO)"; exit 1' ERR
