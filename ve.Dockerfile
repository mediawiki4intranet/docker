FROM mediawiki4intranet

MAINTAINER Vitaliy Filippov

# Add the following line if you need npm:
#    (curl -L https://deb.nodesource.com/setup_8.x | bash -) && \
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /home/wiki4intranet/www/configs && \
    php repo.php update mediawiki4intranet-with-ve ro && \
    mv /home/wiki4intranet/www/LocalSettings.php /home/wiki4intranet/www/LocalSettings-noVE.php

ADD ve/config.yaml /home/wiki4intranet/www/parsoid-deploy/config.yaml
ADD ve/LocalSettings.php /home/wiki4intranet/www/LocalSettings.php
ADD ve/start-ve.sh /home/start-ve.sh

CMD /home/start-ve.sh
