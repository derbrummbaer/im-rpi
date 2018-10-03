############################################################
# Dockerfile zum erstellen eines Dockercontainers für
# homegear
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

# Repository für Pilight
RUN apt-get update && \
	apt-get install apt-transport-https wget ca-certificates apt-utils gnupg -qy

############################################################
# Install Software: Homegear
############################################################


RUN echo 'deb https://apt.homegear.eu/Debian/ stretch/' >> /etc/apt/sources.list.d/homegear.list && \
    wget https://apt.homegear.eu/Release.key | apt-key add -
    
RUN apt-get update && \
    apt-get dist-upgrade -qy && \
    apt-get install libzip4 libavahi-client3 libavahi-client-dev insserv -qy

RUN apt-get update && \
    apt-get dist-upgrade -qy && \
    apt-get install \
	homegear \
    homegear-management \
    homegear-webssh \
    homegear-adminui \
    homegear-nodes-core \
    homegear-nodes-extra \
    homegear-homematicbidcos \
    homegear-homematicwired \
    homegear-insteon \
    homegear-max \
    homegear-philipshue \
    homegear-sonos \
    homegear-kodi \
    homegear-ipcam \
    homegear-beckhoff \
    homegear-knx \
    homegear-enocean \
    homegear-intertechno \
    homegear-zwave \
    homegear-mbus \
    homegear-ccu2 \
    homegear-influxdb \
	-qy

############################################################
# Remove Apt Data
############################################################

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

############################################################
# Copy External Data
############################################################

RUN rm -f /etc/homegear/dh1024.pem; \
    rm -f /etc/homegear/homegear.crt; \
    rm -f /etc/homegear/homegear.key; \
    cp -R /etc/homegear /etc/homegear.config; \
    cp -R /var/lib/homegear /var/lib/homegear.data

############################################################
# Copy Start Scripts
############################################################

COPY scripte/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

############################################################
# Folders needed
############################################################

VOLUME ["/etc/homegear", "/var/lib/homegear", "/var/log/homegear"]

############################################################
# Ports needed
############################################################

EXPOSE 2001 2002 2003

############################################################
############################################################
# USE CROSS-BUILD for Raspberry PI Images
############################################################
############################################################

RUN [ "cross-build-end" ]

############################################################
# Container Start
############################################################

ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/run.sh"]
