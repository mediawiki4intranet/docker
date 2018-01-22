#!/bin/sh

git clone https://github.com/mediawiki4intranet/configs
cd configs && git show --quiet --format='%cd-%H' --date=short HEAD > ../mediawiki4intranet-version && cd .. && rm -rf configs
docker build -t mediawiki4intranet . && \
docker build -t mediawiki4intranet/ve -f ve.Dockerfile .
