FROM debian:jessie-slim

# set version label
LABEL maintainer="bigrob8181"

ARG PUID=1000
ARG PGID=1000

RUN \
    echo "**** Add User and Group ****" && \
    addgroup --gid ${PGID} abc && \
    adduser --uid ${PUID} --gid ${PGID} abc


RUN \
 echo "**** install Base dependencies ****" && \
 apt update && \
 apt install --no-cache \
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
    mariadb-server \
    composer


#access the server.

#mysql

#create the database and users:

#create database lychee;
#CREATE USER lychee@localhost IDENTIFIED BY 'password';
#GRANT ALL ON *.* TO lychee@localhost WITH GRANT OPTION;
#FLUSH PRIVILEGES;
#exit;


RUN \
    echo "**** Clone the repo ****" && \
    cd /var/www/html && \
    git clone --recurse-submodules https://github.com/LycheeOrg/Lychee-Laravel.git


#RUN \
#    echo "**** Set things up ****" && \
    #cd Lychee-Laravel && \
    #cp .env.example .env

# edit .env to match the parameters


RUN \
    echo "**** install php libraries ****" && \
    cd /var/www/html/Lychee-Laravel && \
    composer install --no-dev


RUN \
    echo "**** generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
    cd /var/www/html/Lychee-Laravel && \
    ./artisan key:generate


RUN \
    echo "**** migrate the database ****" && \
    cd /var/www/html/Lychee-Laravel && \
    ./artisan migrate


RUN \
    echo "**** Laravel requires mode rewrite to be enabled ****" && \
    a2enmod rewrite


RUN \
    echo "**** Customize apache2.conf ****" && \
    echo "\
<Directory /var/www/html/Lychee-Laravel> \
	Options Indexes FollowSymLinks \
	AllowOverride All \
	Require all granted \
</Directory>" >> /etc/apache2/apache2.conf


RUN \
    echo "**** Add custom Site to apache and enable it ****"
COPY default.conf /etc/apache2/site-available/default.conf
RUN \
    a2ensite default.conf


#Restart apache2:
#systemctl restart apache2


EXPOSE 80
VOLUME /conf

WORKDIR /var/www/html/Lychee-Laravel

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

#CMD ["python", "-m", "lycheesync.sync", "/photos", "/lycheepath", "/conf/conf.json", "-c", "-v"]
