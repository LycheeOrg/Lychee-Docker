#!/bin/bash

set -e

# Read Last commit hash from .git
# This prevents installing git, and allows display of commit
read -r longhash < /var/www/html/Lychee/.git/refs/heads/master
shorthash=$(echo $longhash |cut -c1-7)
lycheeversion=$(</var/www/html/Lychee/version.md)
target=$(</var/www/html/Lychee/docker_target)

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
Lychee Version: '$lycheeversion' ('$target')
Lychee Commit:  '$shorthash'
https://github.com/LycheeOrg/Lychee/commit/'$longhash'
-------------------------------------'

echo "**** Make sure the /conf and /uploads folders exist ****"
[ ! -f /conf ]    && mkdir -p /conf
[ ! -f /uploads ] && mkdir -p /uploads
[ ! -f /sym ]     && mkdir -p /sym

echo "**** Create the symbolic link for the /uploads folder ****"
[ ! -L /var/www/html/Lychee/public/uploads ] && \
	cp -r /var/www/html/Lychee/public/uploads/* /uploads && \
	rm -r /var/www/html/Lychee/public/uploads && \
	ln -s /uploads /var/www/html/Lychee/public/uploads

echo "**** Create the symbolic link for the /sym folder ****"
[ ! -L /var/www/html/Lychee/public/sym ] && \
	touch /var/www/html/Lychee/public/sym/empty_file && \
	cp -r /var/www/html/Lychee/public/sym/* /sym && \
	rm -r /var/www/html/Lychee/public/sym && \
	ln -s /sym /var/www/html/Lychee/public/sym

cd /var/www/html/Lychee

if [ "$DB_CONNECTION" = "sqlite" ]
	then if [ -n "$DB_DATABASE" ]
		then if [ ! -e "$DB_DATABASE" ]
			then echo "**** Specified sqlite database doesn't exist. Creating it ****"
			echo "**** Please make sure your database is on a persistent volume ****"
			touch "$DB_DATABASE"
		fi
		chown www-data:www-data "$DB_DATABASE"
	else DB_DATABASE="/var/www/html/Lychee/database/database.sqlite"
		export DB_DATABASE
		if [ ! -L database/database.sqlite ]
			then [ ! -e /conf/database.sqlite ] && \
			echo "**** Copy the default database to /conf ****" && \
			cp database/database.sqlite /conf/database.sqlite
			echo "**** Create the symbolic link for the database ****"
			rm database/database.sqlite
			ln -s /conf/database.sqlite database/database.sqlite
			chown -h www-data:www-data /conf /conf/database.sqlite database/database.sqlite
		fi
	fi
fi

echo "**** Copy the .env to /conf ****" && \
[ ! -e /conf/.env ] && \
	cp /var/www/html/Lychee/.env.example /conf/.env
[ ! -L /var/www/html/Lychee/.env ] && \
	ln -s /conf/.env /var/www/html/Lychee/.env
echo "**** Inject .env values ****" && \
	/inject.sh

[ ! -e /tmp/first_run ] && \
	echo "**** Generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	./artisan key:generate && \
	echo "**** Migrate the database ****" && \
	./artisan migrate --force && \
	touch /tmp/first_run

echo "**** Create user and use PUID/PGID ****"
PUID=${PUID:-1000}
PGID=${PGID:-1000}
if [ ! "$(id -u "$USER")" -eq "$PUID" ]; then usermod -o -u "$PUID" "$USER" ; fi
if [ ! "$(id -g "$USER")" -eq "$PGID" ]; then groupmod -o -g "$PGID" "$USER" ; fi
echo -e " \tUser UID :\t$(id -u "$USER")"
echo -e " \tUser GID :\t$(id -g "$USER")"

echo "**** Set Permissions ****" && \
chown "$USER":"$USER" /conf/.env
chown -R "$USER":"$USER" /uploads
chown -R "$USER":"$USER" /sym
usermod -a -G "$USER" www-data
chmod -R 775 /uploads

echo "**** Setup complete, starting the server. ****"
php-fpm7.3
exec $@
