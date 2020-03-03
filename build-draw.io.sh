#!/bin/bash
# A script to build a self-hosted draw.io instance

set -e

sudo apt-get install default-jdk ant
[ -e drawio ] || git clone https://github.com/mediawiki4intranet/drawio
cd drawio/etc/build
ant
cd ../../..
cp drawio/build/draw.war ./
