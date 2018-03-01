#!/bin/bash
install () {
    echo "Installing $@..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated $@
}
install libpq-dev
install python3
install python3-dev
install python3-venv
install python3-pip