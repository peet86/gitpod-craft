#!/bin/bash

echo "Init DB tunnel.."
ssh ${LIVE_SSH_LOGIN} -f -N -p ${LIVE_SSH_PORT} -o "StrictHostKeyChecking no" -L 3306:127.0.0.1:3306 -N