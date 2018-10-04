#!/bin/bash

if  ! [ "$(ls -A /opt/iobroker/iobroker-data)" ]; then
    echo "Neu Installation, Verschiebe Daten"
    mv /opt/iobroker.data/node_modules/* /opt/iobroker/node_modules
    mv /opt/iobroker.data/iobroker-data/* /opt/iobroker/iobroker-data
    mv /opt/iobroker.data/log/* /opt/iobroker/log
    rm -r /opt/iobroker.data
    cd /opt/iobroker
else
    echo "Installation schon vorhanden"
    cd /opt/iobroker
fi

echo "Konfiguriere IOBroker"
./iobroker host $(cat .install_host) && echo $(hostname) > .install_host

echo "Starte IOBroker"
node node_modules/iobroker.js-controller/controller.js
