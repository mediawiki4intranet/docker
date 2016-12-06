#!/bin/sh

git clone https://github.com/mediawiki4intranet/configs
cd configs && echo `date '+%Y-%m-%d'`-`git rev-parse HEAD` > ../mediawiki4intranet-version && cd .. && rm -rf configs
docker build -t mediawiki4intranet .
docker build -t mediawiki4intranet/ve -f ve.Dockerfile .
