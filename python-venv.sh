#!/bin/bash
VENV=${1:-"$HOME/.app-venv"}
REQUIREMENTS=${2:-"$HOME/app/requirements.txt"}
install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}
echo "--- Installation of Python 3 with venv and pip ---"
install libpq-dev
install python3
install python3-dev
install python3-venv
install python3-pip
echo "Creating the virtual env..."
python3 -m venv $VENV
. $VENV/bin/activate
echo "Updating pip..."
pip install --upgrade pip > /dev/null 2>&1
pip install wheel > /dev/null 2>&1
pip install --upgrade setuptools > /dev/null 2>&1
echo "Installing the requirements..."
pip install -r $REQUIREMENTS
deactivate
echo "--- All done! ---"