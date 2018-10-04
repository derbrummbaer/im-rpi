############################################################
# Dockerfile zum erstellen eines Dockercontainers für
# iobroker
############################################################

############################################################
# Argument Variables from YAML File
############################################################

FROM resin/rpi-raspbian:stretch

# File Author / Maintainer
MAINTAINER Sven Berger

############################################################
############################################################
# USE CROSS-BUILD for Raspberry PI Images
############################################################
############################################################

#COPY bin/ /usr/bin/
RUN [ "cross-build-start" ]

############################################################
# don't ask for stupid things
############################################################

ENV DEBIAN_FRONTEND noninteractive
RUN echo APT::Install-Recommends "0"; >> /etc/apt/apt.conf
RUN echo APT::Install-Suggests "0"; >> /etc/apt/apt.conf

############################################################
# Environment Variables
############################################################

############################################################
# User Ändern
############################################################

############################################################
# Upgrade Software: Installed
############################################################

RUN apt-get update && \
	apt-get install wget apt-transport-https wget ca-certificates apt-utils gnupg -qy

############################################################
# Install Software: IoBroker
############################################################

ENV V_NODEJS=v8.12.0

# Node.js installieren
# RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && \
    apt-get install -qy build-essential libavahi-compat-libdnssd-dev libudev-dev libpam0g-dev nodejs

WORKDIR /tmp

RUN wget "http://nodejs.org/dist/$V_NODEJS/node-$V_NODEJS-linux-armv6l.tar.gz" && \
    tar -xvf "node-$V_NODEJS-linux-armv6l.tar.gz"  -C /usr/local --strip-components=1 && \
    rm "node-$V_NODEJS-linux-armv6l.tar.gz" && \
    ln -s /usr/local/bin/node /usr/bin/nodejs && \
    cd .. && \
    rm -rf /tmp/*

# NPM Downgrade wg. Bug in NPM5
RUN npm install -g npm@4

# Installation von IOBroker

RUN mkdir -p /opt/iobroker/ && chmod 777 /opt/iobroker

WORKDIR /opt/iobroker/

RUN npm install iobroker --unsafe-perm && \
    echo $(hostname) > .install_host    

############################################################
# Remove Apt Data
############################################################

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

############################################################
# Copy External Data
############################################################

############################################################
# Copy Start Scripts
############################################################

ADD scripte/run.sh run.sh
RUN chmod +x run.sh

############################################################
# Folders needed
############################################################

VOLUME ["/opt/iobroker/"]

############################################################
# Ports needed
############################################################

EXPOSE 8081

############################################################
############################################################
# USE CROSS-BUILD for Raspberry PI Images
############################################################
############################################################

RUN [ "cross-build-end" ]

############################################################
# Container Start
############################################################

CMD 	["/opt/iobroker/run.sh"]
