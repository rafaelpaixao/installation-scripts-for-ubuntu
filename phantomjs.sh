#!/bin/bash
PHANTOM_VERSION=${1:-2.1.1}
FILENAME=phantomjs-$PHANTOM_VERSION-linux-x86_64.tar.bz2

echo "--- Installation of Phantom JS $PHANTOM_VERSION ---"

if ! [ -x "$(command -v phantomjs)" ]; then
    echo "Downloading..."
    sudo wget -q https://bitbucket.org/ariya/phantomjs/downloads/$FILENAME > /dev/null 2>&1
    echo "Installing..."
    sudo tar xvjf $FILENAME -C /usr/local/share/ > /dev/null 2>&1
    sudo ln -s /usr/local/share/$FILENAME/bin/phantomjs /usr/local/bin/ > /dev/null 2>&1
    echo "Cleaning..."
    sudo rm $FILENAME
    echo "--- All done! ---"
else
    echo "PhantomJS is already installed!"
fi