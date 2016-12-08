FROM debian:stretch

MAINTAINER Vitaliy Filippov

ADD etc/apt/apt.conf /etc/apt/apt.conf
ADD etc/locale.gen /etc/locale.gen

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" install -y wget git zip unzip poppler-utils \
    netpbm librsvg2-bin locales djvulibre-bin texlive-base texlive-extra-utils ffmpeg \
    dia graphviz gnuplot plotutils umlet default-jre diffutils imagemagick sphinxsearch \
    mc nginx php7.0-fpm php7.0-cli php7.0-json php7.0-opcache php7.0-mbstring php7.0-curl php7.0-gd \
    php7.0-intl php7.0-mysql php7.0-xml php7.0-zip php-imagick php-apcu php-apcu-bc php-pear php-mail php-net-smtp mariadb-server

ADD etc /etc
ADD home /home
ADD usr /usr

RUN service mysql start && echo "CREATE DATABASE mediawiki; \
    GRANT ALL PRIVILEGES ON mediawiki.* TO mediawiki@localhost IDENTIFIED BY 'mediawiki'; \
    FLUSH PRIVILEGES;" | mysql --defaults-file=/etc/mysql/debian.cnf

RUN wget http://wiki.4intra.net/public/tika-app.jar -O /home/wiki4intranet/tika-app.jar && \
    rm -f /etc/nginx/sites-enabled/default

RUN mkdir -p /home/wiki4intranet/data/images && \
    chown www-data:www-data /home/wiki4intranet/data/images && \
    mv /var/lib/mysql /home/wiki4intranet/data/mysql && \
    mv /var/lib/sphinxsearch /home/wiki4intranet/data/sphinxsearch && \
    ln -s /home/wiki4intranet/data/mysql /var/lib/mysql && \
    ln -s /home/wiki4intranet/data/sphinxsearch /var/lib/sphinxsearch && \
    mkdir /home/wiki4intranet/data/logs && \
    mv /var/log/nginx /home/wiki4intranet/data/logs && \
    ln -s /home/wiki4intranet/data/logs/nginx /var/log/nginx && \
    mv /var/log/mysql /home/wiki4intranet/data/logs && \
    ln -s /home/wiki4intranet/data/logs/mysql /var/log/mysql && \
    mv /var/log/sphinxsearch /home/wiki4intranet/data/logs && \
    ln -s /home/wiki4intranet/data/logs/sphinxsearch /var/log/sphinxsearch && \
    cd /home/wiki4intranet/www && \
    ln -s /home/wiki4intranet/data/images && \
    git clone https://github.com/mediawiki4intranet/configs && \
    touch /home/wiki4intranet/data/debug.log && \
    chown www-data /home/wiki4intranet/data/debug.log && \
    cd configs && php repo.php install mediawiki4intranet ro

RUN service sphinxsearch start && \
    service mysql start && \
    service tika start && \
    cd /home/wiki4intranet/www && \
    php maintenance/patchSql.php maintenance/tables.sql && \
    php maintenance/update.php --quick && \
    php maintenance/createAndPromote.php --bureaucrat --sysop WikiSysop MediaWiki4Intranet

# Update image incrementally

ADD mediawiki4intranet-version /etc/mediawiki4intranet-version

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" dist-upgrade -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /home/wiki4intranet/www/configs && \
    php repo.php update

CMD /home/start.sh

EXPOSE 80

VOLUME /home/wiki4intranet/data
