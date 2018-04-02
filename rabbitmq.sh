#!/bin/bash
echo "--- Installation of RabbitMQ Server ---"
echo "Add repo..."
echo 'deb http://www.rabbitmq.com/debian/ testing main' |
     sudo tee /etc/apt/sources.list.d/rabbitmq.list >/dev/null 2>&1
wget -qO- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
     sudo apt-key add - >/dev/null 2>&1
echo "System update..."
sudo apt-get update > /dev/null 2>&1
echo "Installing..."
sudo apt-get install -qq --fix-missing --allow-unauthenticated rabbitmq-server > /dev/null 2>&1
rabbitmq-plugins enable rabbitmq_management > /dev/null 2>&1
echo "--- All done! ---"
