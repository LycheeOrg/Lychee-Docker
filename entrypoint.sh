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

echo "Permissions"
# permissions
chown -R abc:abc \
	/conf \
	/var/www/html/Lychee-Laravel

echo "Start it"
systemctl restart apache2
