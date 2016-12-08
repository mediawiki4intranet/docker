FROM mediawiki4intranet

MAINTAINER Vitaliy Filippov

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" install -y nodejs npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /home/wiki4intranet/www/configs && \
    php repo.php update mediawiki4intranet-with-ve ro && \
    mv /home/wiki4intranet/www/LocalSettings.php /home/wiki4intranet/www/LocalSettings-noVE.php

ADD ve/config.yaml /home/wiki4intranet/www/parsoid-deploy/config.yaml
ADD ve/LocalSettings.php /home/wiki4intranet/www/LocalSettings.php
ADD ve/start-ve.sh /home/start-ve.sh

CMD /home/start-ve.sh
