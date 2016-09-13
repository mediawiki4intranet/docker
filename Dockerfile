FROM debian:stretch

MAINTAINER Vitaliy Filippov

ADD etc/apt/apt.conf /etc/apt/apt.conf

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" install -y wget git zip unzip poppler-utils \
    netpbm djvulibre-bin texlive-base texlive-extra-utils ffmpeg \
    graphviz gnuplot plotutils umlet default-jre diffutils imagemagick sphinxsearch \
    nginx php7.0-fpm php7.0-cli php7.0-json php7.0-opcache php7.0-mbstring php7.0-curl php7.0-gd \
    php7.0-intl php7.0-mysql php7.0-xml php7.0-zip php-imagick php-apcu php-apcu-bc php-mail php-net-smtp mariadb-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD etc /etc
ADD home /home
ADD usr /usr

RUN service mysql start && echo "CREATE DATABASE mediawiki; \
    GRANT ALL PRIVILEGES ON mediawiki.* TO mediawiki@localhost IDENTIFIED BY 'mediawiki'; \
    FLUSH PRIVILEGES;" | mysql --defaults-file=/etc/mysql/debian.cnf

RUN wget http://wiki.4intra.net/public/tika-app.jar -O /home/wiki4intranet/tika-app.jar && \
    rm -f /etc/nginx/sites-enabled/default && \
    cd /home/wiki4intranet/www && git clone https://github.com/mediawiki4intranet/configs && \
    cd configs && php repo.php install mediawiki4intranet ro && cd .. && \
    chown www-data:www-data images

RUN service sphinxsearch start && \
    service mysql start && \
    service tika start && \
    cd /home/wiki4intranet/www && \
    php maintenance/patchSql.php maintenance/tables.sql && \
    php maintenance/update.php --quick

CMD service tika start && service sphinxsearch start && service php7.0-fpm start && service mysql start && service nginx start

EXPOSE 80

# need https://github.com/openid/php-openid (removed from PEAR for some reason)
# need sendmail... what to do with it?
