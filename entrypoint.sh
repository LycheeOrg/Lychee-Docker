#!/bin/bash

echo "**** Starting the Entrypoint Script ****"
set -e


echo "**** Make sure the /conf folder exists ****"
[[ ! -f /conf ]] && \
mkdir -p \
	/conf


echo "**** Copy the .env to /conf ****" && \
[[ ! -e /conf/.env ]] && \
	cp /var/www/html/Lychee-Laravel/.env.example /conf/.env
[[ ! -L /var/www/html/Lychee-Laravel/.env ]] && \
	ln -s /conf/.env /var/www/html/Lychee-Laravel/.env


echo "**** Set Permissions ****" && \
chown -R abc:abc \
	/conf \
	/var/www/html/Lychee-Laravel


[[ ! -e /tmp/first_run ]] && \
	echo "**** generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	cd /var/www/html/Lychee-Laravel && \
	./artisan key:generate && \
	echo "**** migrate the database ****" && \
	cd /var/www/html/Lychee-Laravel && \
	./artisan migrate && \
	touch /tmp/first_run && \
	/etc/init.d/apache2 stop

/etc/init.d/apache2 start
