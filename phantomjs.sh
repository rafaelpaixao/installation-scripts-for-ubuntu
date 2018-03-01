PHANTOM_VERSION=${1:-2.1.1}
echo "Downloading..."
sudo wget -q https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOM_VERSION-linux-x86_64.tar.bz2
echo "Installing..."
sudo tar xvjf phantomjs-$PHANTOM_VERSION-linux-x86_64.tar.bz2 -C /usr/local/share/
sudo ln -s /usr/local/share/phantomjs-$PHANTOM_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin/
echo "Cleaning..."
sudo rm phantomjs-$PHANTOM_VERSION-linux-x86_64.tar.bz2
echo "All done!"
