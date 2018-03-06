#!/bin/bash

PMA_IP=${1:-0.0.0.0}
PMA_PORT=${2:-5050}
MYSQL_ROOT_PASS=${3:-"root"}

echo "--- Installation of PHPMyAdmin as a service ---"

if [ ! -f /etc/systemd/system/phpmyadmin.service ]; then
echo "Configuring..."
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password "$MYSQL_ROOT_PASS
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password "$MYSQL_ROOT_PASS
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password "$MYSQL_ROOT_PASS
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

echo "Installing..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated install phpmyadmin > /dev/null 2>&1

echo "Creating service..."
sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
sudo -u root echo '
[Unit]
Description=Phpmyadmin Service
After=network.target

[Service]
Type=simple
NonBlocking=true
ExecStart=/usr/bin/php -S '$PMA_IP':'$PMA_PORT' -t /usr/share/phpmyadmin
ExecStop=killall -9 php
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/phpmyadmin.service

sudo -u root systemctl daemon-reload
sudo -u root systemctl enable phpmyadmin
sudo -u root systemctl start phpmyadmin

echo -e "\nAll done! Go to:\n\thttp://$PMA_IP:$PMA_PORT"

else
    echo "PHPMyAdmin service already exists!"
fi
