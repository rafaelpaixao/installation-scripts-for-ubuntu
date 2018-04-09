APP_NAME="Supervisor"

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

install supervisor

echo "Applying some fixes..."

sudo touch /var/run/supervisor.sock
sudo chmod 777 /var/run/supervisor.sock

if [ -f /etc/supervisor/supervisor.conf ]; then
    sudo rm /etc/supervisor/supervisor.conf
fi
sudo -u root sh <<EOF
sudo echo "
[unix_http_server]
file=/var/run/supervisor.sock
chmod=0777

[supervisord]
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
childlogdir=/var/log/supervisor

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock

[include]
files = /etc/supervisor/conf.d/*.conf
" > /etc/supervisor/supervisor.conf
EOF

sudo -u root systemctl reload supervisor

echo "------ Script for $APP_NAME... Done!"