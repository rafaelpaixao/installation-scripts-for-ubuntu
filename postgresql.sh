#!/bin/bash

<<COMMENT
    params:
        --user       Username for new user, optional
        --pass       Password for new user, if not provided will use the same value of pguser
        --db         Name for new database, if not provided will use the same value of pguser
    example:
        bash postgresql.sh --user ubuntu
COMMENT

while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        declare $v="$2"
   fi
  shift
done

echo -e "\n--- Installation of PostgreSQL Server ---\n"

if ! [ -x "$(command -v psql)" ]; then 

echo "Installing..."
sudo apt-get install -qq --fix-missing --allow-unauthenticated postgresql > /dev/null 2>&1
sudo apt-get install -qq --fix-missing --allow-unauthenticated postgresql-contrib > /dev/null 2>&1

if [ -z ${user+x} ]; then
    echo "User not provided, skipping..."
else
    if [ -z ${pass+x} ]; then
        echo "Pass not provided, using the same value of user..."
        pass=$user
    fi
    if [ -z ${db+x} ]; then
        echo "Database's name not provided, using the same value of user..."
        db=$user
    fi
    echo "Creating user and database..."
sudo -u postgres sh <<EOF
psql -c "CREATE USER $user PASSWORD '$pass'";
psql -c "CREATE DATABASE $db";
psql -c "GRANT ALL PRIVILEGES ON DATABASE $db TO $user";
psql -c "ALTER USER postgres PASSWORD 'postgres'";
EOF
fi
echo -e "\n--- All done! ---\n"

else
    echo "Postgres is already installed!"
fi
