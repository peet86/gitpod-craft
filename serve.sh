#!/bin/bash
echo "  ___  ____   __   ____  ____            ___  __  ____  ____   __  ____  "
echo " / __)(  _ \ / _\ (  __)(_  _)   ___    / __)(  )(_  _)(  _ \ /  \(    \ "
echo "( (__  )   //    \ ) _)   )(    (___)  ( (_ \ )(   )(   ) __/(  O )) D ( "
echo " \___)(__\_)\_/\_/(__)   (__)           \___/(__) (__) (__)   \__/(____/ "
echo " "
echo "  S E R V E  C R A F T "
echo " "
echo "-------------------------------------------------------------------------"

eval $(gp env -e) 

echo "> Sync SSH keys"
gitpod/ssh-key-sync.sh

echo "> Open SSH tunnel to Live DB"
gitpod/mysql-tunnel.sh 

echo "> Update PHP configuration"
if [ -f gitpod-custom/php-fpm.conf ]; then
    gitpod-custom/php-fpm.conf
else 
    gitpod/php-fpm.conf
fi

if [ -f gitpod-custom/php.ini ]; then
    gitpod-custom/php.ini
else 
    gitpod/php.ini
fi

echo "> Start/restart php-fpm"
killall -KILL php-fpm
/usr/sbin/php-fpm7.4 

echo "> Update Nginx configuration"
if [ -f gitpod-custom/nginx.conf ]; then
    gitpod-custom/nginx.conf
else 
    gitpod/nginx.conf
fi

echo "> Start/reload nginx"
nginx
nginx -s reload  

echo "> Start log monitoring.."
multitail /var/log/nginx/access.log -I /var/log/nginx/error.log