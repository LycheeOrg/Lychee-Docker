#!/bin/sh

echo "in entrypoint"
set -e

# create our folders
mkdir -p \
	/conf

echo "Copy config"
# copy config
[[ ! -e /conf/.env ]] && \
	cp /var/www/html/Lychee-Laravel/.env.example /conf/.env
[[ ! -L /var/www/html/Lychee-Laravel/.env ]] && \
	ln -s /conf/.env /var/www/html/Lychee-Laravel/.env

# Customize apache2.conf
#[[ ! -e /etc/apache2/apache2.conf.bak ]] && \
#	cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak && \
#	echo "
#<Directory /var/www/html/Lychee-Laravel>
#	Options Indexes FollowSymLinks
#	AllowOverride All
#	Require all granted
#</Directory>" >> /etc/apache2/apache2.conf

echo "Permissions"
# permissions
chown -R abc:abc \
	/conf \
	/var/www/html/Lychee-Laravel

echo "Start it"
systemctl restart apache2
