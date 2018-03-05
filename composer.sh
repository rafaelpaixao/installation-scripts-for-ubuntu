#!/bin/bash

echo "--- Installation of Composer ---"
echo "Downloading..."
curl -sS https://getcomposer.org/installer -o composer-setup.php > /dev/null 2>&1
echo "Installing..."
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer > /dev/null 2>&1
echo "Fix permissions..."
sudo chown -R $USER $HOME/.composer > /dev/null 2>&1
echo "Cleaning..."
rm composer-setup.php > /dev/null 2>&1
echo "--- All done! ---"