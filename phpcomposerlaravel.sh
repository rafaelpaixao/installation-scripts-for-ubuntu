#!/bin/bash

install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}
echo "--- Installation of PHP 7 with Composer and Laravel ---"

if ! [ -x "$(command -v laravel)" ]; then 
    install curl
    install unzip
    install python-software-properties
    sudo add-apt-repository ppa:ondrej/php > /dev/null 2>&1
    echo "System update..."
    sudo apt-get -qq update > /dev/null 2>&1
    install php7.2-cli
    install php7.2-mysql
    install php7.2-curl
    install php7.2-json
    install php7.2-cgi
    install php7.2-xsl
    install php7.2-mbstring
    install php7.2-xml
    install php7.2-gd
    install php7.2-gettext
    install php7.2-zip
    install php7.2-cli
    install php7.2-cgi
    install php7.2-fpm

    echo "Installing Composer..."
    curl -sS https://getcomposer.org/installer -o composer-setup.php > /dev/null 2>&1
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer > /dev/null 2>&1
    rm composer-setup.php

    echo "Installing Laravel..."
    sudo chown -R $USER $HOME/.composer > /dev/null 2>&1
    composer global require "laravel/installer" > /dev/null 2>&1

    sudo echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc
    . ~/.bashrc

    echo "--- All done! ---"
else
    echo "Laravel is already installed!"
fi
