#!/bin/bash
# SSH key setup

echo "> Syncing ssh keys" 
mkdir -p ~/.ssh

cp gitpod/.ssh/id_rsa ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

cp gitpod/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/id_rsa.pub


