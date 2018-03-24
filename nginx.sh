#!/bin/bash

install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}
echo "--- Installation of Nginx Server ---"

if ! [ -x "$(command -v nginx)" ]; then 
    install nginx
    echo "--- All done! ---"
else
    echo "Nginx is already installed!"
fi
