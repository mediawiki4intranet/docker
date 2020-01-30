FROM debian:sid

MAINTAINER Vitaliy Filippov

ADD etc/apt/apt.conf /etc/apt/apt.conf
ADD etc/apt/sources.list /etc/apt/sources.list
ADD etc/locale.gen /etc/locale.gen

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" install -y cron wget git zip unzip poppler-utils \
    netpbm librsvg2-bin libvisio-tools locales djvulibre-bin texlive-base texlive-extra-utils texlive-latex-extra ffmpeg dvipng \
    dia graphviz gnuplot plotutils umlet default-jre diffutils imagemagick sphinxsearch ca-certificates gnupg2 \
    mc less nginx php7.3-fpm php7.3-cli php7.3-json php7.3-opcache php7.3-mbstring php7.3-curl php7.3-gd \
    php7.3-intl php7.3-mysql php7.3-xml php7.3-zip php-imagick php-apcu php-pear php-mail-mime php-mail php-net-smtp mariadb-server && \
    apt-get -y clean && rm -rf /var/lib/apt/lists/*

ADD etc /etc
ADD home /home
ADD usr /usr

RUN service mysql start && echo "CREATE DATABASE mediawiki; \
    GRANT ALL PRIVILEGES ON mediawiki.* TO mediawiki@localhost IDENTIFIED BY 'mediawiki'; \
    FLUSH PRIVILEGES;" | mysql --defaults-file=/etc/mysql/debian.cnf

RUN wget http://wiki.4intra.net/public/tika-app.jar -O /home/wiki4intranet/tika-app.jar && \
    rm -f /etc/nginx/sites-enabled/default

RUN mkdir -p /home/data/images && \
    chown www-data:www-data /home/data/images && \
    mv /var/lib/mysql /home/data/mysql && \
    mv /var/lib/sphinxsearch /home/data/sphinxsearch && \
    ln -s /home/data/mysql /var/lib/mysql && \
    ln -s /home/data/sphinxsearch /var/lib/sphinxsearch && \
    mkdir /home/data/logs && \
    mv /var/log/nginx /home/data/logs && \
    ln -s /home/data/logs/nginx /var/log/nginx && \
    mv /var/log/mysql /home/data/logs && \
    ln -s /home/data/logs/mysql /var/log/mysql && \
    mv /var/log/sphinxsearch /home/data/logs && \
    ln -s /home/data/logs/sphinxsearch /var/log/sphinxsearch && \
    cd /home/wiki4intranet/www && \
    ln -s /home/data/images && \
    git clone https://github.com/mediawiki4intranet/configs && \
    touch /home/data/debug.log && \
    chown www-data /home/data/debug.log && \
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
