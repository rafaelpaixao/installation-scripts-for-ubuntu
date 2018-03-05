#!/bin/bash
echo "--- Installation of NodeJS 8 ---"
echo "Add repo..."
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh > /dev/null 2>&1
sudo bash nodesource_setup.sh > /dev/null 2>&1
sudo rm nodesource_setup.sh
echo "System update..."
sudo apt-get -qq update > /dev/null 2>&1
echo "Installing..."
sudo apt-get install -qq --fix-missing --allow-unauthenticated nodejs > /dev/null 2>&1
echo "Updating NPM..."
sudo npm i -g --silent npm
echo "Fix permissions..."
sudo chown -R $USER:$USER $HOME/.config
echo "--- All done! ---"
