echo -e "\n--- Installation of Supervisor ---\n"

install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}

install supervisor

echo "Applying some fixes..."

sudo touch /var/run/supervisor.sock
sudo chmod 777 /var/run/supervisor.sock

if [ -f /tmp/foo.txt ]; then
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

echo -e "\n--- All done! ---\n"
