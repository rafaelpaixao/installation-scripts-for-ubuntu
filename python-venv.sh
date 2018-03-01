#!/bin/bash
VENV=${1:-"$HOME/.app-venv"}
REQUIREMENTS=${2:-"$HOME/app/requirements.txt"}
install () {
    echo "Installing $@..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated $@
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
pip install --upgrade pip
pip install wheel
pip install --upgrade setuptools
echo "Installing the requirements..."
pip install -r $REQUIREMENTS
deactivate
echo "--- All done! ---"