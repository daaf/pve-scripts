#!/usr/bin/env bash

source ./common.sh

msg_info "Updating Proxmox VE..."

if apt-get update && apt-get -y dist-upgrade; then
    msg_ok "Updated Proxmox VE"
else
    msg_error "Update failed"
    exit 1
fi
