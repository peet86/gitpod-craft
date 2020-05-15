#!/bin/bash
# SSH key setup

echo "> Paste your SSH public and private key to id_rsa.pub and id_rsa (above) and save the files" 

mkdir -p gitpod/.ssh

touch gitpod/.ssh/id_rsa
gp open gitpod/.ssh/id_rsa

touch gitpod/.ssh/id_rsa.pub
gp open gitpod/.ssh/id_rsa.pub
