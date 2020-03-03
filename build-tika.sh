#!/bin/bash
# A script to build Tika-CLI 1.2 server for the TikaMW extension

set -e

sudo apt-get install default-jdk maven
[ -e apache-tika-1.2-src.zip ] || wget http://archive.apache.org/dist/tika/apache-tika-1.2-src.zip
[ -e patch-tika1.2-org.apache.tika.cli.TikaCLI.diff ] || wget https://raw.githubusercontent.com/mediawiki4intranet/TikaMW/master/patch-tika1.2-org.apache.tika.cli.TikaCLI.diff
[ -e tika-1.2 ] || unzip apache-tika-1.2-src.zip
cd tika-1.2
patch -p0 < ../patch-tika1.2-org.apache.tika.cli.TikaCLI.diff
mvn package
cd ..
cp tika-1.2/tika-app/target/tika-app-1.2.jar ./
