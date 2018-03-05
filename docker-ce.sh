#!/bin/bash
install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}
echo "--- Installation of Docker Community Edition and Docker Compose ---"
install apt-transport-https
install ca-certificates
install curl
install software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
echo "System update..."
sudo apt-get -qq update > /dev/null 2>&1
install  docker-ce
sudo usermod -aG docker $USER;
echo "Installing Docker Compose..."
sudo curl -sSL https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null 2>&1
sudo chmod +x /usr/local/bin/docker-compose
echo "--- All done! ---"