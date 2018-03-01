#!/bin/bash

MYSQL_USER=${1:-"root"}
MYSQL_PASS=${2:-"root"}
MYSQL_DB=${3:-"example"}
MYSQL_ROOT_PASS=${4:-"root"}

echo "--- Installation of MySQL Server ---"

echo "Configuring..."
debconf-set-selections <<< "mysql-server mysql-server/root_password password "$MYSQL_ROOT_PASS
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password "$MYSQL_ROOT_PASS
echo "Installing..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated install mysql-server > /dev/null 2>&1
echo "Creating default database..."
mysql -uroot -p$MYSQL_ROOT_PASS -e "CREATE DATABASE "$MYSQL_DB;
mysql -uroot -p$MYSQL_ROOT_PASS -e "grant all privileges on "$MYSQL_DB".* to '"$MYSQL_USER"'@'localhost' identified by '"$MYSQL_PASS"'";
echo "--- All done! ---"