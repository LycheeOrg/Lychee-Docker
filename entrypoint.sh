#!/bin/bash

echo "**** Starting the Entrypoint Script ****"
set -e


echo "**** Make sure the /conf and /uploads folders exist ****"
[[ ! -f /conf ]] && \
	mkdir -p /conf
[ ! -f /uploads ]] && \
	mkdir -p /uploads

echo "**** Create the symbolic link for the /uploads folder ****"
[[ ! -L /var/www/html/Lychee-Laravel/public/uploads ]] && \
	cp /var/www/html/Lychee-Laravel/public/uploads/* /uploads && \
	rm -r /var/www/html/Lychee-Laravel/public/uploads && \
	ln -s /uploads /var/www/html/Lychee-Laravel/public/uploads

echo "**** Copy the .env to /conf ****" && \
[[ ! -e /conf/.env ]] && \
	cp /var/www/html/Lychee-Laravel/.env.example /conf/.env
[[ ! -L /var/www/html/Lychee-Laravel/.env ]] && \
	ln -s /conf/.env /var/www/html/Lychee-Laravel/.env


echo "**** Set Permissions ****" && \
chown -R abc:abc /conf
chown -R abc:abc /uploads
chmod -R a+rw /uploads

[[ ! -e /tmp/first_run ]] && \
	echo "**** generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	cd /var/www/html/Lychee-Laravel && \
	./artisan key:generate && \
	echo "**** migrate the database ****" && \
	cd /var/www/html/Lychee-Laravel && \
	./artisan migrate && \
	touch /tmp/first_run

exec $@
