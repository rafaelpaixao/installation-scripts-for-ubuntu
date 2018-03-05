#!/bin/bash
install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}
install libpq-dev
install python3
install python3-dev
install python3-venv
install python3-pip