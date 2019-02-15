FROM debian:buster-slim

# set version label
LABEL maintainer="bigrob8181"

# environment variables
ENV PUID='1000'
ENV PGID='1000'
ENV USER='lychee'
ENV PHP_TZ=America/New_York

RUN \
    echo "**** Add User and Group ****" && \
    addgroup --gid "$PGID" "$USER" && \
    adduser --no-create-home --disabled-password --uid "$PUID" --gid "$PGID" "$USER"

RUN \
 echo "**** Install base dependencies ****" && \
    apt update && \
    apt install -y \
    libapache2-mod-php7.3 \
    php7.3-mysql \
    php7.3-imagick \
    php7.3-mbstring \
    php7.3-json \
    php7.3-gd \
    php7.3-xml \
    php7.3-zip && \
    echo "**** Clone the repo ****" && \
    apt install -y git && \
    cd /var/www/html && \
    git clone --recurse-submodules https://github.com/LycheeOrg/Lychee-Laravel.git && \
    echo "**** Install PHP libraries ****" && \
    apt install -y composer && \
    cd /var/www/html/Lychee-Laravel && \
    composer install --no-dev && \
    chown -R www-data:www-data /var/www/html/Lychee-Laravel && \
    apt purge -y git composer && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*


RUN \
    echo "**** Laravel requires mode rewrite to be enabled ****" && \
    a2enmod rewrite


RUN \
    echo "**** Add custom site to apache and enable it ****"
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
