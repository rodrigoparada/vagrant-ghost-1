#!/usr/bin/env bash

# Getting root
sudo su

# Updating repos #1
apt-get -y update

# Adding node.js repo and necessary tools
apt-get install -y python-software-properties
apt-get -y update
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update

# Installing node.js
apt-get -y install nodejs

echo "node.js installed! Version:"
node --version
npm --version