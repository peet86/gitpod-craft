#!/bin/bash
echo "  ___  ____   __   ____  ____            ___  __  ____  ____   __  ____  "
echo " / __)(  _ \ / _\ (  __)(_  _)   ___    / __)(  )(_  _)(  _ \ /  \(    \ "
echo "( (__  )   //    \ ) _)   )(    (___)  ( (_ \ )(   )(   ) __/(  O )) D ( "
echo " \___)(__\_)\_/\_/(__)   (__)           \___/(__) (__) (__)   \__/(____/ "
echo " "
echo "  S E R V E  C R A F T "
echo "-------------------------------------------------------------------------"

eval $(gp env -e) 

echo "> Sync SSH keys"
gitpod/ssh-key-sync.sh

echo "> Open SSH tunnel to Live DB"
gitpod/mysql-tunnel.sh 

echo "> Restart php-fpm"
killall -KILL php-fpm
/usr/sbin/php-fpm7.4 

echo "> Start nginx"
nginx 

echo "> Start log monitoring.."
multitail /var/log/nginx/access.log -I /var/log/nginx/error.log