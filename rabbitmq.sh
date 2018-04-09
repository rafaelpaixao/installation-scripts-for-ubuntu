#!/bin/bash

<<COMMENT
    params:
        --user           Username for new admin, optional
        --pass           Password for the provided user, will use the same value of user if not provided
COMMENT

while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        if [[ ${#2} != 0 &&  $2 != *"--"* ]]; then
            declare $v="$2"
        else
            declare $v="true"
        fi
   fi
  shift
done

APP_NAME="RabbitMQ"

install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}

addrepo () {
    if ! grep -q "$@" /etc/apt/sources.list; then
        echo "Adding repository $@..."
        sudo add-apt-repository -y $@ > /dev/null 2>&1
        echo "System update..."
        sudo apt-get update > /dev/null 2>&1
    else
        echo "The repository $@  already exists in the source.list!"
    fi
}

echo "------ Script for $APP_NAME..."

echo "Add repo..."
echo 'deb http://www.rabbitmq.com/debian/ testing main' |
     sudo tee /etc/apt/sources.list.d/rabbitmq.list >/dev/null 2>&1
wget -qO- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
     sudo apt-key add - >/dev/null 2>&1
echo "System update..."
sudo apt-get update > /dev/null 2>&1

install rabbitmq-server

if [ -z ${user+x} ]; then
    echo "User not defined, skipping..."
else
     if [ -z ${pass+x} ]; then
          echo "Pass not defined, using same value of user..."
          pass=$user
     fi
     sudo rabbitmq-plugins enable rabbitmq_management > /dev/null 2>&1
     sudo rabbitmqctl add_user $user $pass
     sudo rabbitmqctl set_user_tags $user administrator
     sudo rabbitmqctl set_permissions -p / $user ".*" ".*" ".*"
fi

echo "------ Script for $APP_NAME... Done!"
