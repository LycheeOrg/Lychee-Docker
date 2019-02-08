#!/bin/bash

sed -i "s|APP_NAME=Laravel|APP_NAME=${APP_NAME}|i" /conf/.env && \
sed -i "s|APP_ENV=local|APP_ENV=${APP_ENV}|i" /conf/.env && \
sed -i "s|APP_KEY=base64:WQQ0sZoM0aIDMOn9P6axFOCZvrm4F6dTVb5mqCS0DU0=|APP_KEY=${APP_KEY}|i" /conf/.env && \
sed -i "s|APP_DEBUG=true|APP_DEBUG=${APP_DEBUG}|i" /conf/.env && \
sed -i "s|APP_URL=http://localhost|APP_URL=${APP_URL}|i" /conf/.env && \
sed -i "s|LOG_CHANNEL=stack|LOG_CHANNEL=${LOG_CHANNEL}|i" /conf/.env && \
sed -i "s|DB_CONNECTION=mysql|DB_CONNECTION=${DB_CONNECTION}|i" /conf/.env && \
sed -i "s|DB_HOST=mariadb|DB_HOST=${DB_HOST}|i" /conf/.env && \
sed -i "s|DB_PORT=3306|DB_PORT=${DB_PORT}|i" /conf/.env && \
sed -i "s|DB_DATABASE=homestead|DB_DATABASE=${DB_DATABASE}|i" /conf/.env && \
sed -i "s|DB_USERNAME=homestead|DB_USERNAME=${DB_USERNAME}|i" /conf/.env && \
sed -i "s|DB_PASSWORD=secret|DB_PASSWORD=${DB_PASSWORD}|i" /conf/.env && \
sed -i "s|DB_DROP_CLEAR_TABLES_ON_ROLLBACK=false|DB_DROP_CLEAR_TABLES_ON_ROLLBACK=${DB_DROP_CLEAR_TABLES_ON_ROLLBACK}|i" /conf/.env && \
sed -i "s|DB_OLD_LYCHEE_PREFIX=|DB_OLD_LYCHEE_PREFIX=${DB_OLD_LYCHEE_PREFIX}|i" /conf/.env && \
sed -i "s|BROADCAST_DRIVER=log|BROADCAST_DRIVER=${BROADCAST_DRIVER}|i" /conf/.env && \
sed -i "s|CACHE_DRIVER=file|CACHE_DRIVER=${CACHE_DRIVER}|i" /conf/.env && \
sed -i "s|SESSION_DRIVER=file|SESSION_DRIVER=${SESSION_DRIVER}|i" /conf/.env && \
sed -i "s|SESSION_LIFETIME=120|SESSION_LIFETIME=${SESSION_LIFETIME}|i" /conf/.env && \
sed -i "s|QUEUE_DRIVER=sync|QUEUE_DRIVER=${QUEUE_DRIVER}|i" /conf/.env && \
sed -i "s|SECURITY_HEADER_HSTS_ENABLE=false|SECURITY_HEADER_HSTS_ENABLE=${SECURITY_HEADER_HSTS_ENABLE}|i" /conf/.env && \
sed -i "s|REDIS_HOST=127.0.0.1|REDIS_HOST=${REDIS_HOST}|i" /conf/.env && \
sed -i "s|REDIS_PASSWORD=null|REDIS_PASSWORD=${REDIS_PASSWORD}|i" /conf/.env && \
sed -i "s|REDIS_PORT=6379|REDIS_PORT=${REDIS_PORT}|i" /conf/.env && \
sed -i "s|MAIL_DRIVER=smtp|MAIL_DRIVER=${MAIL_DRIVER}|i" /conf/.env && \
sed -i "s|MAIL_HOST=smtp.mailtrap.io|MAIL_HOST=${MAIL_HOST}|i" /conf/.env && \
sed -i "s|MAIL_PORT=2525|MAIL_PORT=${MAIL_PORT}|i" /conf/.env && \
sed -i "s|MAIL_USERNAME=null|MAIL_USERNAME=${MAIL_USERNAME}|i" /conf/.env && \
sed -i "s|MAIL_PASSWORD=null|MAIL_PASSWORD=${MAIL_PASSWORD}|i" /conf/.env && \
sed -i "s|MAIL_ENCRYPTION=null|MAIL_ENCRYPTION=${MAIL_ENCRYPTION}|i" /conf/.env && \
sed -i "s|PUSHER_APP_ID=|PUSHER_APP_ID=${PUSHER_APP_ID}|i" /conf/.env && \
sed -i "s|PUSHER_APP_KEY=|PUSHER_APP_KEY=${PUSHER_APP_KEY}|i" /conf/.env && \
sed -i "s|PUSHER_APP_SECRET=|PUSHER_APP_SECRET=${PUSHER_APP_SECRET}|i" /conf/.env && \
sed -i "s|PUSHER_APP_CLUSTER=mt1|PUSHER_APP_CLUSTER=${PUSHER_APP_CLUSTER}|i" /conf/.env && \
sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/7.3/apache2/php.ini && \
sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/7.3/cli/php.ini
