FROM debian:buster-slim

# set version label
LABEL maintainer="bigrob8181"

# environment variables
ENV PUID=''
ENV PGID=''
ENV PHP_TZ=America/New_York
# taken from .env file
ENV MY_APP_NAME=''
ENV MY_APP_ENV=''
ENV MY_APP_DEBUG=''
ENV MY_APP_URL=''
ENV MY_LOG_CHANNEL=''
ENV MY_DB_CONNECTION=''
ENV MY_DB_HOST=''
ENV MY_DB_PORT=''
ENV MY_DB_DATABASE=''
ENV MY_DB_USERNAME=''
ENV MY_DB_PASSWORD=''
ENV MY_DB_DROP_CLEAR_TABLES_ON_ROLLBACK=''
ENV MY_DB_OLD_LYCHEE_PREFIX=''
ENV MY_BROADCAST_DRIVER=''
ENV MY_CACHE_DRIVER=''
ENV MY_SESSION_DRIVER=''
ENV MY_SESSION_LIFETIME=''
ENV MY_QUEUE_DRIVER=''
ENV MY_SECURITY_HEADER_HSTS_ENABLE=''
ENV MY_REDIS_HOST=''
ENV MY_REDIS_PASSWORD=''
ENV MY_REDIS_PORT=''
ENV MY_MAIL_DRIVER=''
ENV MY_MAIL_HOST=''
ENV MY_MAIL_PORT=''
ENV MY_MAIL_USERNAME=''
ENV MY_MAIL_PASSWORD=''
ENV MY_MAIL_ENCRYPTION=''
ENV MY_PUSHER_APP_ID=''
ENV MY_PUSHER_APP_KEY=''
ENV MY_PUSHER_APP_SECRET=''
ENV MY_PUSHER_APP_CLUSTER=''


RUN \
    echo "**** Add User and Group ****" && \
    adduser --group --no-create-home --disabled-password abc


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
