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
    cp gitpod-custom/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
else 
    cp gitpod/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
fi

if [ -f gitpod-custom/php.ini ]; then
    cp gitpod-custom/php.ini /etc/php/7.4/fpm/php.ini
else 
    cp gitpod/php.ini /etc/php/7.4/fpm/php.ini
fi

echo "> Start/restart php-fpm"
killall -KILL php-fpm
/usr/sbin/php-fpm7.4 

echo "> Update Nginx configuration"
if [ -f gitpod-custom/nginx.conf ]; then
    cp gitpod-custom/nginx.conf /etc/nginx/nginx.conf
else 
    cp gitpod/nginx.conf /etc/nginx/nginx.conf
fi

echo "> Start/reload nginx"
nginx
nginx -s reload  

echo "> Start log monitoring.."
multitail /var/log/nginx/access.log -I /var/log/nginx/error.log
