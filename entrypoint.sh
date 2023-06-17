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

if [ -n "$STARTUP_DELAY" ]
	then echo "**** Delaying startup ($STARTUP_DELAY seconds)... ****"
	sleep $STARTUP_DELAY
fi


echo "**** Make sure the /conf /uploads /sym /logs folders exist ****"
[ ! -d /conf ]    && mkdir -p /conf
[ ! -d /uploads ] && mkdir -p /uploads
[ ! -d /sym ]     && mkdir -p /sym
[ ! -d /logs]     && mkdir -p /logs

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

echo "**** Create the symbolic link for the /logs folder ****"
[ ! -L /var/www/html/Lychee/storage/logs ] && \
	touch /var/www/html/Lychee/storage/logs/empty_file && \
	cp -r /var/www/html/Lychee/storage/logs/* /logs && \
	rm -r /var/www/html/Lychee/storage/logs && \
	ln -s /sym /var/www/html/Lychee/storage/logs

echo "**** Create the symbolic link to the old Lychee-Laravel folder ****"
[ ! -L /var/www/html/Lychee-Laravel ] && \
	ln -s /var/www/html/Lychee /var/www/html/Lychee-Laravel

cd /var/www/html/Lychee

if [ "$DB_CONNECTION" = "sqlite" ] || [ -z "$DB_CONNECTION" ]
	then if [ -n "$DB_DATABASE" ]
		then if [ ! -e "$DB_DATABASE" ]
			then echo "**** Specified sqlite database doesn't exist. Creating it ****"
			echo "**** Please make sure your database is on a persistent volume ****"
			touch "$DB_DATABASE"
			chown www-data:www-data "$DB_DATABASE"
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
	sed 's|^#DB_DATABASE=$|DB_DATABASE='$DB_DATABASE'|' /var/www/html/Lychee/.env.example > /conf/.env
[ ! -L /var/www/html/Lychee/.env ] && \
	ln -s /conf/.env /var/www/html/Lychee/.env
echo "**** Inject .env values ****" && \
	/inject.sh

create_admin_user() {
  if [ "$ADMIN_USER" != '' ]; then
    if [ "$ADMIN_PASSWORD" != '' ]; then
      value=$ADMIN_PASSWORD
    elif [ -e "$ADMIN_PASSWORD_FILE" ] ; then
      value=$(<$ADMIN_PASSWORD_FILE)
    fi
    if [ "$value" != '' ]; then
      echo "**** Creating admin account ****" && \
      php artisan lychee:create_user "$ADMIN_USER" "$value"
    fi
  fi
}

[ ! -e /tmp/first_run ] && \
	echo "**** Generate the key (to make sure that cookies cannot be decrypted etc) ****" && \
	./artisan key:generate -n && \
	echo "**** Migrate the database ****" && \
	./artisan migrate --force && \
	create_admin_user && \
	touch /tmp/first_run

echo "**** Make sure user.css exists and symlink it ****" && \
touch -a /conf/user.css
[ ! -L /var/www/html/Lychee/public/dist/user.css ] && \
	rm /var/www/html/Lychee/public/dist/user.css && \
	ln -s /conf/user.css /var/www/html/Lychee/public/dist/user.css

echo "**** Make sure custom.js exists and symlink it ****" && \
touch -a /conf/custom.js
[ ! -L /var/www/html/Lychee/public/dist/custom.js ] && \
	rm /var/www/html/Lychee/public/dist/custom.js && \
	ln -s /conf/custom.js /var/www/html/Lychee/public/dist/custom.js

echo "**** Create user and use PUID/PGID ****"
PUID=${PUID:-1000}
PGID=${PGID:-1000}
if [ ! "$(id -u "$USER")" -eq "$PUID" ]; then usermod -o -u "$PUID" "$USER" ; fi
if [ ! "$(id -g "$USER")" -eq "$PGID" ]; then groupmod -o -g "$PGID" "$USER" ; fi
echo -e " \tUser UID :\t$(id -u "$USER")"
echo -e " \tUser GID :\t$(id -g "$USER")"

echo "**** Make sure Laravel's log exists ****" && \
touch /logs/laravel.log

echo "**** Set Permissions ****" && \
# Set ownership of directories, then files and only when required. See LycheeOrg/Lychee-Docker#120
find /sym /uploads /logs -type d \( ! -user "$USER" -o ! -group "$USER" \) -exec chown -R "$USER":"$USER" \{\} \;
find /conf/.env /sym /uploads /logs \( ! -user "$USER" -o ! -group "$USER" \) -exec chown "$USER":"$USER" \{\} \;
# Laravel needs to be able to chmod user.css and custom.js for no good reason
find /conf/user.css /conf/custom.js /logs/laravel.log \( ! -user "www-data" -o ! -group "$USER" \) -exec chown www-data:"$USER" \{\} \;
usermod -a -G "$USER" www-data
find /sym /uploads /logs -type d \( ! -perm -ug+w -o ! -perm -ugo+rX -o ! -perm -g+s \) -exec chmod -R ug+w,ugo+rX,g+s \{\} \;
find /conf/user.css /conf/custom.js /conf/.env /sym /uploads /logs \( ! -perm -ug+w -o ! -perm -ugo+rX \) -exec chmod ug+w,ugo+rX \{\} \;

# Update CA Certificates if we're using armv7 because armv7 is weird (#76)
if [[ $(uname -a) == *"armv7"* ]]; then
  echo "**** Updating CA certificates ****"
  update-ca-certificates -f
fi

echo "**** Start cron daemon ****"
service cron start

echo "**** Setup complete, starting the server. ****"
php-fpm8.2
exec $@
