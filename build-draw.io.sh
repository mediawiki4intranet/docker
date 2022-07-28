#!/bin/bash
# A script to build a self-hosted draw.io instance
YUM_CMD=$(which yum)
DNF_CMD=$(which dnf)
APT_GET_CMD=$(which apt-get)

set -e

if [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install default-jdk ant
elif [[ ! -z $DNF_CMD ]]; then
    sudo dnf install ant
elif [[ ! -z $YUM_CMD ]]; then
    sudo yum install ant
else
    echo "Please, install Ant/JDK"
fi

[ -e drawio ] || git clone https://github.com/mediawiki4intranet/drawio
cd drawio/etc/build
ant war
cd ../../..
cp drawio/build/draw.war ./
