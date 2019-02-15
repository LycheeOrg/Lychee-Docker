#!/bin/bash
if [ "$MY_APP_NAME" != '' ]; then
    sed -i "s|APP_NAME=.*|APP_NAME=${MY_APP_NAME}|i" /conf/.env
fi
if [ "$MY_APP_ENV" != '' ]; then
    sed -i "s|APP_ENV=.*|APP_ENV=${MY_APP_ENV}|i" /conf/.env
fi
if [ "$MY_APP_DEBUG" != '' ]; then
    sed -i "s|APP_DEBUG=.*|APP_DEBUG=${MY_APP_DEBUG}|i" /conf/.env
fi
if [ "$MY_APP_URL" != '' ]; then
    sed -i "s|APP_URL=.*|APP_URL=${MY_APP_URL}|i" /conf/.env
fi
if [ "$MY_LOG_CHANNEL" != '' ]; then
    sed -i "s|LOG_CHANNEL=.*|LOG_CHANNEL=${MY_LOG_CHANNEL}|i" /conf/.env
fi
if [ "$MY_DB_CONNECTION" != '' ]; then
    sed -i "s|DB_CONNECTION=.*|DB_CONNECTION=${MY_DB_CONNECTION}|i" /conf/.env
fi
if [ "$MY_DB_HOST" != '' ]; then
    sed -i "s|DB_HOST=.*|DB_HOST=${MY_DB_HOST}|i" /conf/.env
fi
if [ "$MY_DB_PORT" != '' ]; then
    sed -i "s|DB_PORT=.*|DB_PORT=${MY_DB_PORT}|i" /conf/.env
fi
if [ "$MY_DB_DATABASE" != '' ]; then
    sed -i "s|DB_DATABASE=.*|DB_DATABASE=${MY_DB_DATABASE}|i" /conf/.env
fi
if [ "$MY_DB_USERNAME" != '' ]; then
    sed -i "s|DB_USERNAME=.*|DB_USERNAME=${MY_DB_USERNAME}|i" /conf/.env
fi
if [ "$MY_DB_PASSWORD" != '' ]; then
    sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=${MY_DB_PASSWORD}|i" /conf/.env
fi
if [ "$MY_DB_DROP_CLEAR_TABLES_ON_ROLLBACK" != '' ]; then
    sed -i "s|DB_DROP_CLEAR_TABLES_ON_ROLLBACK=.*|DB_DROP_CLEAR_TABLES_ON_ROLLBACK=${MY_DB_DROP_CLEAR_TABLES_ON_ROLLBACK}|i" /conf/.env
fi
if [ "$MY_DB_OLD_LYCHEE_PREFIX" != '' ]; then
    sed -i "s|DB_OLD_LYCHEE_PREFIX=.*|DB_OLD_LYCHEE_PREFIX=${MY_DB_OLD_LYCHEE_PREFIX}|i" /conf/.env
fi
if [ "$MY_BROADCAST_DRIVER" != '' ]; then
    sed -i "s|BROADCAST_DRIVER=.*|BROADCAST_DRIVER=${MY_BROADCAST_DRIVER}|i" /conf/.env
fi
if [ "$MY_CACHE_DRIVER" != '' ]; then
    sed -i "s|CACHE_DRIVER=.*|CACHE_DRIVER=${MY_CACHE_DRIVER}|i" /conf/.env
fi
if [ "$MY_SESSION_DRIVER" != '' ]; then
    sed -i "s|SESSION_DRIVER=.*|SESSION_DRIVER=${MY_SESSION_DRIVER}|i" /conf/.env
fi
if [ "$MY_SESSION_LIFETIME" != '' ]; then
    sed -i "s|SESSION_LIFETIME=.*|SESSION_LIFETIME=${MY_SESSION_LIFETIME}|i" /conf/.env
fi
if [ "$MY_QUEUE_DRIVER" != '' ]; then
    sed -i "s|QUEUE_DRIVER=.*|QUEUE_DRIVER=${MY_QUEUE_DRIVER}|i" /conf/.env
fi
if [ "$MY_SECURITY_HEADER_HSTS_ENABLE" != '' ]; then
    sed -i "s|SECURITY_HEADER_HSTS_ENABLE=.*|SECURITY_HEADER_HSTS_ENABLE=${MY_SECURITY_HEADER_HSTS_ENABLE}|i" /conf/.env
fi
if [ "$MY_REDIS_HOST" != '' ]; then
    sed -i "s|REDIS_HOST=.*|REDIS_HOST=${MY_REDIS_HOST}|i" /conf/.env
fi
if [ "$MY_REDIS_PASSWORD" != '' ]; then
    sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=${MY_REDIS_PASSWORD}|i" /conf/.env
fi
if [ "$MY_REDIS_PORT" != '' ]; then
    sed -i "s|REDIS_PORT=.*|REDIS_PORT=${MY_REDIS_PORT}|i" /conf/.env
fi
if [ "$MY_MAIL_DRIVER" != '' ]; then
    sed -i "s|MAIL_DRIVER=.*|MAIL_DRIVER=${MY_MAIL_DRIVER}|i" /conf/.env
fi
if [ "$MY_MAIL_HOST" != '' ]; then
    sed -i "s|MAIL_HOST=.*|MAIL_HOST=${MY_MAIL_HOST}|i" /conf/.env
fi
if [ "$MY_MAIL_PORT" != '' ]; then
    sed -i "s|MAIL_PORT=.*|MAIL_PORT=${MY_MAIL_PORT}|i" /conf/.env
fi
if [ "$MY_MAIL_USERNAME" != '' ]; then
    sed -i "s|MAIL_USERNAME=.*|MAIL_USERNAME=${MY_MAIL_USERNAME}|i" /conf/.env
fi
if [ "$MY_MAIL_PASSWORD" != '' ]; then
    sed -i "s|MAIL_PASSWORD=.*|MAIL_PASSWORD=${MY_MAIL_PASSWORD}|i" /conf/.env
fi
if [ "$MY_MAIL_ENCRYPTION" != '' ]; then
    sed -i "s|MAIL_ENCRYPTION=.*|MAIL_ENCRYPTION=${MY_MAIL_ENCRYPTION}|i" /conf/.env
fi
if [ "$MY_PUSHER_APP_ID" != '' ]; then
    sed -i "s|PUSHER_APP_ID=.*|PUSHER_APP_ID=${MY_PUSHER_APP_ID}|i" /conf/.env
fi
if [ "$MY_PUSHER_APP_KEY" != '' ]; then
    sed -i "s|PUSHER_APP_KEY=.*|PUSHER_APP_KEY=${MY_PUSHER_APP_KEY}|i" /conf/.env
fi
if [ "$MY_PUSHER_APP_SECRET" != '' ]; then
    sed -i "s|PUSHER_APP_SECRET=.*|PUSHER_APP_SECRET=${MY_PUSHER_APP_SECRET}|i" /conf/.env
fi
if [ "$MY_PUSHER_APP_CLUSTER" != '' ]; then
    sed -i "s|PUSHER_APP_CLUSTER=.*|PUSHER_APP_CLUSTER=${MY_PUSHER_APP_CLUSTER}|i" /conf/.env
fi
if [ "$PHP_TZ" != '' ]; then
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/7.3/cli/php.ini
fi
