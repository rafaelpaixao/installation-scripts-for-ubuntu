#!/bin/bash
echo "--- Installation of RabbitMQ Server ---"
echo "Add repo..."
echo 'deb http://www.rabbitmq.com/debian/ testing main' |
     sudo tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
     sudo apt-key add -
echo "System update..."
sudo DEBIAN_FRONTEND=noninteractive apt-get -y update;
echo "Installing..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated rabbitmq-server
echo "--- All done! ---"
