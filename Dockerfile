FROM debian:buster-slim

# set version label
LABEL maintainer="bigrob8181"

# environment variables
ENV PUID=1000
ENV PGID=1000
ENV PHP_TZ=America/New_York
# taken from .env file
ENV APP_NAME=Laravel
ENV APP_ENV=local
ENV APP_KEY=base64:WQQ0sZoM0aIDMOn9P6axFOCZvrm4F6dTVb5mqCS0DU0=
ENV APP_DEBUG=true
ENV APP_URL=http://localhost
ENV LOG_CHANNEL=stack
ENV DB_CONNECTION=mysql
ENV DB_HOST=mariadb
ENV DB_PORT=3306
ENV DB_DATABASE=homestead
ENV DB_USERNAME=homestead
ENV DB_PASSWORD=secret
ENV DB_DROP_CLEAR_TABLES_ON_ROLLBACK=false
ENV DB_OLD_LYCHEE_PREFIX
ENV BROADCAST_DRIVER=log
ENV CACHE_DRIVER=file
ENV SESSION_DRIVER=file
ENV SESSION_LIFETIME=120
ENV QUEUE_DRIVER=sync
ENV SECURITY_HEADER_HSTS_ENABLE=false
ENV REDIS_HOST=127.0.0.1
ENV REDIS_PASSWORD=null
ENV REDIS_PORT=6379
ENV MAIL_DRIVER=smtp
ENV MAIL_HOST=smtp.mailtrap.io
ENV MAIL_PORT=2525
ENV MAIL_USERNAME=null
ENV MAIL_PASSWORD=null
ENV MAIL_ENCRYPTION=null
ENV PUSHER_APP_ID
ENV PUSHER_APP_KEY
ENV PUSHER_APP_SECRET
ENV PUSHER_APP_CLUSTER=mt1


RUN \
    echo "**** Add User and Group ****" && \
    addgroup --gid ${PGID} abc && \
    adduser --system --no-create-home --uid ${PUID} --gid ${PGID} --disabled-password abc


RUN \
 echo "**** install Base dependencies ****" && \
 apt update && \
 apt install -y \
    bash \
    libapache2-mod-php7.3 \
    git \
    php7.3-mysql \
    php7.3-imagick \
    php7.3-mbstring \
    php7.3-json \
    php7.3-gd \
    php7.3-xml \
    php7.3-zip \
    #mariadb-server \
    composer \
    && rm -rf /var/lib/apt/lists/*


RUN \
    echo "**** Clone the repo ****" && \
    cd /var/www/html && \
    git clone --recurse-submodules https://github.com/LycheeOrg/Lychee-Laravel.git


RUN \
    echo "**** install php libraries ****" && \
    cd /var/www/html/Lychee-Laravel && \
    composer install --no-dev && \
    chown -R www-data:www-data \
    	/var/www/html/Lychee-Laravel


RUN \
    echo "**** Laravel requires mode rewrite to be enabled ****" && \
    a2enmod rewrite


RUN \
    echo "**** Add custom Site to apache and enable it ****"
COPY default.conf /etc/apache2/sites-available/default.conf
RUN \
    ls -la /etc/apache2/sites-available/ && \
    a2ensite default.conf && \
    a2dissite 000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf


EXPOSE 80
VOLUME /conf /uploads

WORKDIR /var/www/html/Lychee-Laravel

COPY entrypoint.sh /entrypoint.sh
COPY inject.sh /inject.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /inject.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "apache2ctl", "-D", "FOREGROUND" ]
