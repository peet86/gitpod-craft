#!/bin/bash

read -p "> Live Server SSH login (eg.: user@server): " remote_ssh_login

read -p "> Live Server SSH port (eg: 22): " remote_ssh_port

# SSH tunnel for remote db access
gp env LIVE_SSH_PORT="$remote_ssh_port"

gp env LIVE_SSH_LOGIN="$remote_ssh_login"

eval $(gp env -e) 
