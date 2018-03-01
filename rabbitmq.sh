#!/bin/bash
echo "--- Installation of RabbitMQ Server ---"
echo "Add repo..."
echo 'deb http://www.rabbitmq.com/debian/ testing main' |
     sudo tee /etc/apt/sources.list.d/rabbitmq.list >/dev/null 2>&1
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
     sudo apt-key add - >/dev/null 2>&1
echo "System update..."
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq update;
echo "Installing..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --fix-missing --allow-unauthenticated rabbitmq-server
echo "--- All done! ---"
