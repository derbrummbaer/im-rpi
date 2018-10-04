#!/bin/sh

if  [ "$(ls -A /opt/iobroker)" ]; then
    mv /opt/iobroker.data /opt/iobroker
    cd /opt/iobroker
else
    cd /opt/iobroker
fi

./iobroker host $(cat .install_host) && echo $(hostname) > .install_host

node node_modules/iobroker.js-controller/controller.js
