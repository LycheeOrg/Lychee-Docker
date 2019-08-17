#!/bin/sh

set -e

# Read Last commit hash from .git
# This prevents installing git, and allows display of commit
read -r longhash < /var/www/html/Lychee-Laravel/.git/refs/heads/master
shorthash=$(echo $longhash |cut -c1-7)

echo '
-------------------------------------
  _               _                
 | |   _   _  ___| |__   ___  ___  
 | |  | | | |/ __|  _ \ / _ \/ _ \ 
 | |__| |_| | (__| | | |  __/  __/ 
 |_____\__, |\___|_| |_|\___|\___| 
 | |   |___/ _ __ __ ___   _____| |
 | |   / _'\'' | '\''__/ _'\'' \ \ / / _ \ |
 | |__| (_| | | | (_| |\ V /  __/ |
 |_____\__,_|_|  \__,_| \_/ \___|_|

-------------------------------------
Latest Commit: '$shorthash'
https://github.com/LycheeOrg/Lychee-Laravel/commit/'$longhash'
-------------------------------------'

echo "**** Make sure the /conf and /uploads folders exist ****"
[ ! -f /conf ] && \
	mkdir -p /conf
[ ! -f /uploads ] && \
	mkdir -p /uploads

echo "**** Create the symbolic link for the /uploads folder ****"
[ ! -L /var/www/html/Lychee-Laravel/public/uploads ] && \
	cp -r /var/www/html/Lychee-Laravel/public/uploads/* /uploads && \
	rm -r /var/www/html/Lychee-Laravel/public/uploads && \
	ln -s /uploads /var/www/html/Lychee-Laravel/public/uploads

echo "**** Copy the .env to /conf ****" && \
[ ! -e /conf/.env ] && \
	cp /var/www/html/Lychee-Laravel/.env.example /conf/.env
[ ! -L /var/www/html/Lychee-Laravel/.env ] && \
	ln -s /conf/.env /var/www/html/Lychee-Laravel/.env
echo "**** Inject .env values ****" && \
	/inject.sh

[ ! -e /tmp/first_run ] && \
	echo "**** Generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	cd /var/www/html/Lychee-Laravel && \
	./artisan key:generate && \
	echo "**** Migrate the database ****" && \
	cd /var/www/html/Lychee-Laravel && \
	./artisan migrate && \
	touch /tmp/first_run

echo "**** Create user and use PUID/PGID ****"
PUID=${PUID:-1000}
PGID=${PGID:-1000}
if [ ! "$(id -u "$USER")" -eq "$PUID" ]; then usermod -o -u "$PUID" "$USER" ; fi
if [ ! "$(id -g "$USER")" -eq "$PGID" ]; then groupmod -o -g "$PGID" "$USER" ; fi
echo -e " \tUser UID :\t$(id -u "$USER")"
echo -e " \tUser GID :\t$(id -g "$USER")"

echo "**** Set Permissions ****" && \
chown -R "$USER":"$USER" /conf
chown -R "$USER":"$USER" /uploads
chmod -R a+rw /uploads
chown -R www-data:www-data /var/www/html/Lychee-Laravel

echo "**** Setup complete, starting the server. ****"
php-fpm7.3
exec $@
