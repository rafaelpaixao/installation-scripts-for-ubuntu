#!/bin/bash

PMA_IP=${1:-0.0.0.0}
PMA_PORT=${2:-4040}
MYSQL_ROOT_PASS=${3:-"root"}

echo "--- Installation of PHPMyAdmin as a service ---"

if [ ! -f /etc/systemd/system/phpmyadmin.service ]; then

    echo "Configuring..."
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password "$MYSQL_ROOT_PASS
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password "$MYSQL_ROOT_PASS
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password "$MYSQL_ROOT_PASS
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

    echo "Add repo..."
    sudo add-apt-repository --yes ppa:nijel/phpmyadmin > /dev/null 2>&1
    echo "System update..."
    sudo apt-get update > /dev/null 2>&1

    echo "Installing..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated phpmyadmin > /dev/null 2>&1
    sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php

    echo "Creating service..."
    sudo -u root sh <<EOF
    sudo echo "
    [Unit]
    Description=Phpmyadmin Service
    After=network.target

    [Service]
    Type=simple
    NonBlocking=true
    ExecStart=/usr/bin/php -S $PMA_IP:$PMA_PORT -t /usr/share/phpmyadmin
    ExecStop=killall -9 php
    Restart=always
    RestartSec=3

    [Install]
    WantedBy=multi-user.target
    " > /etc/systemd/system/phpmyadmin.service
EOF

    sudo -u root systemctl daemon-reload
    sudo -u root systemctl enable phpmyadmin
    sudo -u root systemctl start phpmyadmin

    echo -e "\nAll done! Go to:\n\thttp://$PMA_IP:$PMA_PORT"

else
    echo "PHPMyAdmin service already exists!"
fi
