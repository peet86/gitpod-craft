#!/bin/bash
echo "  ___  ____   __   ____  ____            ___  __  ____  ____   __  ____  "
echo " / __)(  _ \ / _\ (  __)(_  _)   ___    / __)(  )(_  _)(  _ \ /  \(    \ "
echo "( (__  )   //    \ ) _)   )(    (___)  ( (_ \ )(   )(   ) __/(  O )) D ( "
echo " \___)(__\_)\_/\_/(__)   (__)           \___/(__) (__) (__)   \__/(____/ "
echo " "
echo "  I N S T A L L  C R A F T "
echo "-------------------------------------------------------------------------"
echo " 1. CRAFT INSTALL"
echo "-------------------------------------------------------------------------"

echo "> Creating missing folders"
mkdir -p storage

echo "> Installing dependencies"
composer install

echo "-------------------------------------------------------------------------"
echo " 2. SSH TUNNEL SETUP (for remote DB)"
echo "-------------------------------------------------------------------------"

if [ -z "$LIVE_SSH_LOGIN" ]; then
    gitpod/ssh-tunnel-setup.sh
else 
    echo "> [skip]"
fi  

if [ -f gitpod/.ssh/id_rsa ]; then
    echo "> [skip]"
else 
    gitpod/ssh-key-setup.sh
    read -p "> [Press ENTER to continue]"
fi

if [ -f ~/.ssh/id_rsa ]; then
    echo "> [skip]"
else 
     gitpod/ssh-key-sync.sh
fi
   
echo "-------------------------------------------------------------------------"
echo " 3. ENVIRONMENT SETUP FOR CRAFT"
echo "-------------------------------------------------------------------------"

if [ -z "$DB_DATABASE" ]; then
    gitpod/craft-env-setup.sh
else 
    echo "> [skip]"
fi  

echo "-------------------------------------------------------------------------"
echo " 4. WORKSPACE URL SETUP"
echo "-------------------------------------------------------------------------"

# init current urls
gitpod/url-update.sh

echo "-------------------------------------------------------------------------"
echo " 5. DONE."
echo "-------------------------------------------------------------------------"
