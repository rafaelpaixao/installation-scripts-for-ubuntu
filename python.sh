#!/bin/bash

<<COMMENT
    params:
        --version       3.6 or anything else for 3.5
        --venv          path for venv
        --req           path for requirements.txt
    example:
        bash python.sh --version 3.6 --venv /home/vagrant/.app --req /home/vagrant/shared/requirements.txt
COMMENT


while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        if [[ ${#2} != 0 &&  $2 != *"--"* ]]; then
            declare $v="$2"
        else
            declare $v="true"
        fi
   fi
  shift
done

if [ -z ${version+x} ]; then
    version="3.5"
fi

if [ "$version" != "3.6" ]; then
  version="3.5"
fi

APP_NAME="Python $version"

install () {
    echo "Installing $@..."
    sudo apt-get install -qq --fix-missing --allow-unauthenticated $@ > /dev/null 2>&1
}

addrepo () {
    if ! grep -q "$@" /etc/apt/sources.list; then
        echo "Adding repository $@..."
        sudo add-apt-repository -y $@ > /dev/null 2>&1
        echo "System update..."
        sudo apt-get update > /dev/null 2>&1
    else
        echo "The repository $@  already exists in the source.list!"
    fi
}

echo "------ Script for $APP_NAME..."

install build-essential
install libpq-dev
install libssl-dev
install libffi-dev

if [ "$version" == "3.5" ]; then
    install python3
    install python3-dev
    install python3-venv
fi
if [ "$version" == "3.6" ]; then
    addrepo ppa:deadsnakes/ppa
    install python3.6
    install python3.6-dev
    install python3.6-venv
fi

if [ -z ${venv+x} ]; then
    echo "Path for venv is not defined, skipping..."
else
    echo "Creating the virtual env..."
    if [ "$version" == "3.5" ]; then
        python3 -m venv $venv
    fi
    if [ "$version" == "3.6" ]; then
        python3.6 -m venv $venv
    fi
    . $venv/bin/activate

    if [ -z ${req+x} ]; then
        echo "Path for requirements is not defined, skipping..."
    else
        echo "Updating pip..."
        curl -fsSL https://bootstrap.pypa.io/get-pip.py | python
        pip install -q --upgrade pip > /dev/null 2>&1
        pip install -q wheel > /dev/null 2>&1
        pip install -q --upgrade setuptools > /dev/null 2>&1
        echo "Installing the requirements..."
        pip install -q -r $req
    fi

    deactivate
fi

echo "------ Script for $APP_NAME... Done!"