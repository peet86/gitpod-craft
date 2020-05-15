#!/bin/bash

read -p "> Database Host (eg. 127.0.0.1): " server

read -p "> Database Port (eg. 3306): " port

read -p "> Database Name: " db

read -p "> Database User: " user

read -p "> Database Password: " password

read -p "> Database Table prefix: " prefix

read -p "> Craft Security key: " security_key

read -p "> Live site url (eg. http://yoursite.com): " live_url

# The environment Craft is currently running in ('dev', 'staging', 'production', etc.)
gp env ENVIRONMENT="dev"

# The secure key Craft will use for hashing and encrypting data
gp env SECURITY_KEY="$security_key"

# The database driver that will be used ('mysql' or 'pgsql')
gp env DB_DRIVER="mysql"

# The database server name or IP address (usually this is 'localhost' or '127.0.0.1')
gp env DB_SERVER="$server"

# The database username to connect with
gp env DB_USER="$user"

# The database password to connect with
gp env DB_PASSWORD="$password"

# The name of the database to select
gp env DB_DATABASE="$db"

# The database schema that will be used (PostgreSQL only)
gp env DB_SCHEMA="public"

# The prefix that should be added to generated table names (only necessary if multiple things are sharing the same database)
gp env DB_TABLE_PREFIX="$prefix"

# The port to connect to the database with. Will default to 5432 for PostgreSQL and 3306 for MySQL.
gp env DB_PORT="$port"

gp env ASSET_URL="$live_url"

eval $(gp env -e) 
