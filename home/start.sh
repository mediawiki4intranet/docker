#!/bin/sh

export LC_ALL=ru_RU.UTF-8 LANG=ru_RU.UTF-8

service draw.io start
service tika start
service sphinxsearch start
service php7.3-fpm start
service mysql start
service nginx start

# Run maintenance/update.php --quick after each startup to handle container image updates
if [ "$NOUPDATE" = "" ]; then
    cd /home/wiki4intranet/www
    php maintenance/update.php --quick
fi

# Keep container running
tail -fn0 /dev/null
