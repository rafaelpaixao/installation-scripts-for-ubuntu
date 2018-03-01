#!/bin/bash
echo "--- Installation of NodeJS 8 ---"
echo "Add repo..."
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
echo "System update..."
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq update
echo "Installing..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated nodejs
echo "Updating NPM..."
sudo npm i -g --silent npm;
echo "Fix permissions..."
sudo chown -R $USER:$USER $HOME/.config
echo "--- All done! ---"
