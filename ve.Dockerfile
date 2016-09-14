FROM mediawiki4intranet

MAINTAINER Vitaliy Filippov

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" install -y nodejs npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /home/wiki4intranet/www/configs && \
    php repo.php update mediawiki4intranet-with-ve ro

ADD ve/config.yaml /home/wiki4intranet/www/parsoid-deploy/config.yaml
ADD ve/LocalSettings.php /home/wiki4intranet/www/LocalSettings.php

CMD export LC_ALL=ru_RU.UTF-8 LANG=ru_RU.UTF-8; service tika start && service sphinxsearch start && \
    service php7.0-fpm start && service mysql start && service nginx start && \
    start-stop-daemon -S -b --pidfile /var/run/parsoid.pid -d /home/wiki4intranet/www/parsoid-deploy -m -x /usr/bin/nodejs -- src/bin/server.js && \
    tail -fn0 /dev/null
