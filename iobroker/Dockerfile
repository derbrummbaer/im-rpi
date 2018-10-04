############################################################
# Dockerfile zum erstellen eines Dockercontainers für
# iobroker
# inspired by https://github.com/Locke/docker-iobroker
############################################################

############################################################
# Argument Variables from YAML File
############################################################

FROM resin/raspberrypi3-node:8

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
	apt-get dist-upgrade -qy

############################################################
# Install Software: IoBroker
############################################################

RUN mkdir -p /opt/iobroker/ && chmod 777 /opt/iobroker

WORKDIR /opt/iobroker/

RUN npm install -g npm@4

RUN npm install iobroker --unsafe-perm && \
    echo $(hostname) > .install_host

############################################################
# Remove Apt Data
############################################################

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

############################################################
# Copy External Data
############################################################

RUN mkdir -p /opt/iobroker.data/iobroker-data && \
    mv /opt/iobroker/iobroker-data/* /opt/iobroker.data/iobroker-data && \
    mkdir -p /opt/iobroker.data/log && \
    mv /opt/iobroker/log/* /opt/iobroker.data/log && \
    mkdir -p /opt/iobroker.data/node_modules && \
    mv /opt/iobroker/node_modules/* /opt/iobroker.data/node_modules

############################################################
# Copy Start Scripts
############################################################

ADD scripte/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

############################################################
# Folders needed
############################################################

VOLUME ["/opt/iobroker/iobroker-data"]
VOLUME ["/opt/iobroker/log"]
VOLUME ["/opt/iobroker/node_modules"]

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

CMD 	["/usr/local/bin/run.sh"]

# Docker run Command
# docker run -ti --rm -p 8081:8081 -v /root/dockerdata/iobroker/iobroker-data:/opt/iobroker/iobroker-data -v /root/dockerdata/iobroker/log:/opt/iobroker/log -v /root/dockerdata/iobroker/node_modules:/opt/iobroker/node_modules --name iobroker -t derbrummbaer/im-auto-iobroker-rpi:test