#!/bin/sh

export LC_ALL=ru_RU.UTF-8 LANG=ru_RU.UTF-8

start-stop-daemon -S -b --pidfile /var/run/parsoid.pid -d /home/wiki4intranet/www/parsoid-deploy -m -x /usr/bin/nodejs -- src/bin/server.js

/home/start.sh
