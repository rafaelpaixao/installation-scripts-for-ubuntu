#!/bin/bash

install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}
echo "--- Installation of Redis Server ---"

if ! [ -x "$(command -v redis-benchmark)" ]; then 
    install redis-server
    echo "--- All done! ---"
else
    echo "Redis is already installed!"
fi
