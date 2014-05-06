#!/usr/bin/env bash

BASE_DIR=/vagrant
GHOST_DIR_NAME=ghost-latest

echo "Checking for ghost installation in ${BASE_DIR}/${GHOST_DIR_NAME}"
if [ ! -d "${BASE_DIR}/${GHOST_DIR_NAME}" ]
then
	echo "Ghost not found, downloading latest version now"
	cd ${BASE_DIR}
	curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
	unzip -uo ghost.zip -d ${GHOST_DIR_NAME}
	rm -f ghost.zip
	echo "Ghost downloaded, now doing npm install --development"
	cd ${GHOST_DIR_NAME}
	npm install --development
    
    # Set up config.js
    cp config.example.js config.js
    # Edit config.js to allow connections from outside the VM
    sed -i "s/127.0.0.1/0.0.0.0/g" ./config.js
    
    # Copy pre-filled database
    cp ../vagrant/ghost-dev-prefilled.db ./content/data/ghost-dev.db
    
    # Create alias for starting node-Server
    echo "alias startghost='cd ${BASE_DIR}/${GHOST_DIR_NAME} && npm start'" >> /home/vagrant/.profile
    
    # Move Ghost themes directory for easier access
    if [ ! -d "${BASE_DIR}/themes" ]
    then
        mv ${BASE_DIR}/${GHOST_DIR_NAME}/content/themes ${BASE_DIR}
    else
        rm -fd ${BASE_DIR}/${GHOST_DIR_NAME}/content/themes/
    fi
    ln -s ${BASE_DIR}/themes ${BASE_DIR}/${GHOST_DIR_NAME}/content/themes
fi