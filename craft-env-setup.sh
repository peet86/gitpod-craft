
read -p "> Live Server Database: " remote_db

read -p "> Live Server Database User: " remote_db_user

read -p "> Live Server Database Password: " remote_db_password

read -p "> Live Server Database Table prefix: " remote_db_prefix

read -p "> Craft Security key: " security_key

read -p "> Live site url (eg. http://yoursite.com): " live_url

# The environment Craft is currently running in ('dev', 'staging', 'production', etc.)
gp env ENVIRONMENT="dev"

# The secure key Craft will use for hashing and encrypting data
gp env SECURITY_KEY="$security_key"

# The database driver that will be used ('mysql' or 'pgsql')
gp env DB_DRIVER="mysql"

# The database server name or IP address (usually this is 'localhost' or '127.0.0.1')
gp env DB_SERVER="127.0.0.1"

# The database username to connect with
gp env DB_USER="$remote_db_user"

# The database password to connect with
gp env DB_PASSWORD="$remote_db_password"

# The name of the database to select
gp env DB_DATABASE="$remote_db"

# The database schema that will be used (PostgreSQL only)
gp env DB_SCHEMA="public"

# The prefix that should be added to generated table names (only necessary if multiple things are sharing the same database)
gp env DB_TABLE_PREFIX="$remote_db_prefix"

# The port to connect to the database with. Will default to 5432 for PostgreSQL and 3306 for MySQL.
gp env DB_PORT="3306"

gp env ASSET_URL="$live_url"

eval $(gp env -e) 
