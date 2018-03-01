#!/bin/bash

POSTGRES_USER=${1:-"root"}
POSTGRES_PASS=${2:-"root"}
POSTGRES_DB=${3:-"example"}

echo "--- Installation of PostgreSQL Server ---"

echo "Installing..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated install postgresql > /dev/null 2>&1
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated install postgresql-contrib > /dev/null 2>&1
echo "Creating user and database..."
sudo -u postgres sh <<EOF
    psql -c "CREATE USER $POSTGRES_USER PASSWORD '$POSTGRES_PASS'";
    psql -c "CREATE DATABASE $POSTGRES_DB";
    psql -c "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER";
    psql -c "ALTER USER postgres PASSWORD 'postgres'";
EOF
echo "--- All done! ---"