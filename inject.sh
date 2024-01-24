#!/bin/bash
if [ "$APP_NAME" != '' ]; then
    sed -i "s|APP_NAME=.*|APP_NAME=${APP_NAME}|i" /conf/.env
fi
if [ "$APP_ENV" != '' ]; then
    sed -i "s|APP_ENV=.*|APP_ENV=${APP_ENV}|i" /conf/.env
fi
if [ "$APP_DEBUG" != '' ]; then
    sed -i "s|APP_DEBUG=.*|APP_DEBUG=${APP_DEBUG}|i" /conf/.env
fi
if [ "$APP_URL" != '' ]; then
    sed -i "s|APP_URL=.*|APP_URL=${APP_URL}|i" /conf/.env
fi
if [ "$APP_FORCE_HTTPS" != '' ]; then
    sed -i "s|APP_FORCE_HTTPS=.*|APP_FORCE_HTTPS=${APP_FORCE_HTTPS}|i" /conf/.env
fi
if [ "$APP_DIR" != '' ]; then
    sed -i "s|APP_DIR=.*|APP_DIR=${APP_DIR}|i" /conf/.env
fi
if [ "$DEBUGBAR_ENABLED" != '' ]; then
    sed -i "s|DEBUGBAR_ENABLED=.*|DEBUGBAR_ENABLED=${DEBUGBAR_ENABLED}|i" /conf/.env
fi
if [ "$LEGACY_V4_REDIRECT" != '' ]; then
    sed -i "s|LEGACY_V4_REDIRECT=.*|LEGACY_V4_REDIRECT=${LEGACY_V4_REDIRECT}|i" /conf/.env
fi
if [ "$DB_OLD_LYCHEE_PREFIX" != '' ]; then
    sed -i "s|DB_OLD_LYCHEE_PREFIX=.*|DB_OLD_LYCHEE_PREFIX=${DB_OLD_LYCHEE_PREFIX}|i" /conf/.env
fi
if [ "$DB_CONNECTION" != '' ]; then
    sed -i "s|DB_CONNECTION=.*|DB_CONNECTION=${DB_CONNECTION}|i" /conf/.env
fi
if [ "$DB_HOST" != '' ]; then
    sed -i "s|DB_HOST=.*|DB_HOST=${DB_HOST}|i" /conf/.env
fi
if [ "$DB_PORT" != '' ]; then
    sed -i "s|DB_PORT=.*|DB_PORT=${DB_PORT}|i" /conf/.env
fi
if [ "$DB_DATABASE" != '' ]; then
    sed -i "s|DB_DATABASE=.*|DB_DATABASE=${DB_DATABASE}|i" /conf/.env
fi
if [ "$DB_USERNAME" != '' ]; then
    sed -i "s|DB_USERNAME=.*|DB_USERNAME=${DB_USERNAME}|i" /conf/.env
fi
if [ "$DB_PASSWORD" != '' ]; then
    sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=${DB_PASSWORD}|i" /conf/.env
elif [ "$DB_PASSWORD_FILE" != '' ]; then
    value=$(<$DB_PASSWORD_FILE)
    sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=${value}|i" /conf/.env
fi
if [ "$DB_LOG_SQL" != '' ]; then
    sed -i "s|DB_LOG_SQL=.*|DB_LOG_SQL=${DB_LOG_SQL}|i" /conf/.env
fi
if [ "$DB_LOG_SQL_EXPLAIN" != '' ]; then
    sed -i "s|DB_LOG_SQL_EXPLAIN=.*|DB_LOG_SQL_EXPLAIN=${DB_LOG_SQL_EXPLAIN}|i" /conf/.env
fi
if [ "$TIMEZONE" != '' ]; then
    sed -i "s|TIMEZONE=.*|TIMEZONE=${TIMEZONE}|i" /conf/.env
fi
if [ "$ENABLE_TOKEN_AUTH" != '' ]; then
    sed -i "s|ENABLE_TOKEN_AUTH=.*|ENABLE_TOKEN_AUTH=${ENABLE_TOKEN_AUTH}|i" /conf/.env
fi
if [ "$CACHE_DRIVER" != '' ]; then
    sed -i "s|CACHE_DRIVER=.*|CACHE_DRIVER=${CACHE_DRIVER}|i" /conf/.env
fi
if [ "$SESSION_DRIVER" != '' ]; then
    sed -i "s|SESSION_DRIVER=.*|SESSION_DRIVER=${SESSION_DRIVER}|i" /conf/.env
fi
if [ "$SESSION_LIFETIME" != '' ]; then
    sed -i "s|SESSION_LIFETIME=.*|SESSION_LIFETIME=${SESSION_LIFETIME}|i" /conf/.env
fi
if [ "$QUEUE_CONNECTION" != '' ]; then
    sed -i "s|QUEUE_DRIVER=.*|QUEUE_DRIVER=${QUEUE_DRIVER}|i" /conf/.env
fi
if [ "$SECURITY_HEADER_HSTS_ENABLE" != '' ]; then
    sed -i "s|SECURITY_HEADER_HSTS_ENABLE=.*|SECURITY_HEADER_HSTS_ENABLE=${SECURITY_HEADER_HSTS_ENABLE}|i" /conf/.env
fi
if [ "$SECURITY_HEADER_CSP_CONNECT_SRC" != '' ]; then
    sed -i "s|SECURITY_HEADER_CSP_CONNECT_SRC=.*|SECURITY_HEADER_CSP_CONNECT_SRC=${SECURITY_HEADER_CSP_CONNECT_SRC}|i" /conf/.env
fi
if [ "$SECURITY_HEADER_SCRIPT_SRC_ALLOW" != '' ]; then
    sed -i "s|SECURITY_HEADER_SCRIPT_SRC_ALLOW=.*|SECURITY_HEADER_SCRIPT_SRC_ALLOW=${SECURITY_HEADER_SCRIPT_SRC_ALLOW}|i" /conf/.env
fi
if [ "$SESSION_SECURE_COOKIE" != '' ]; then
    sed -i "s|SESSION_SECURE_COOKIE=.*|SESSION_SECURE_COOKIE=${SESSION_SECURE_COOKIE}|i" /conf/.env
fi
if [ "$REDIS_SCHEME" != '' ]; then
    sed -i "s|REDIS_SCHEME=.*|REDIS_SCHEME=${REDIS_SCHEME}|i" /conf/.env
fi
if [ "$REDIS_PATH" != '' ]; then
    sed -i "s|REDIS_PATH=.*|REDIS_PATH=${REDIS_PATH}|i" /conf/.env
fi
if [ "$REDIS_HOST" != '' ]; then
    sed -i "s|REDIS_HOST=.*|REDIS_HOST=${REDIS_HOST}|i" /conf/.env
fi
if [ "$REDIS_PORT" != '' ]; then
    sed -i "s|REDIS_PORT=.*|REDIS_PORT=${REDIS_PORT}|i" /conf/.env
fi
if [ "$REDIS_PASSWORD" != '' ]; then
    sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=${REDIS_PASSWORD}|i" /conf/.env
elif [ "$REDIS_PASSWORD_FILE" != '' ]; then
    value=$(<$REDIS_PASSWORD_FILE)
    sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=${value}|i" /conf/.env
fi
if [ "$MAIL_DRIVER" != '' ]; then
    sed -i "s|MAIL_DRIVER=.*|MAIL_DRIVER=${MAIL_DRIVER}|i" /conf/.env
fi
if [ "$MAIL_HOST" != '' ]; then
    sed -i "s|MAIL_HOST=.*|MAIL_HOST=${MAIL_HOST}|i" /conf/.env
fi
if [ "$MAIL_PORT" != '' ]; then
    sed -i "s|MAIL_PORT=.*|MAIL_PORT=${MAIL_PORT}|i" /conf/.env
fi
if [ "$MAIL_USERNAME" != '' ]; then
    sed -i "s|MAIL_USERNAME=.*|MAIL_USERNAME=${MAIL_USERNAME}|i" /conf/.env
fi
if [ "$MAIL_PASSWORD" != '' ]; then
    sed -i "s|MAIL_PASSWORD=.*|MAIL_PASSWORD=${MAIL_PASSWORD}|i" /conf/.env
elif [ "$MAIL_PASSWORD_FILE" != '' ]; then
    value=$(<$MAIL_PASSWORD_FILE)
    sed -i "s|MAIL_PASSWORD=.*|MAIL_PASSWORD=${value}|i" /conf/.env
fi
if [ "$MAIL_ENCRYPTION" != '' ]; then
    sed -i "s|MAIL_ENCRYPTION=.*|MAIL_ENCRYPTION=${MAIL_ENCRYPTION}|i" /conf/.env
fi
if [ "$MAIL_FROM_NAME" != '' ]; then
    sed -i "s|MAIL_FROM_NAME=.*|MAIL_FROM_NAME=${MAIL_FROM_NAME}|i" /conf/.env
fi
if [ "$MAIL_FROM_ADDRESS" != '' ]; then
    sed -i "s|MAIL_FROM_ADDRESS=.*|MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}|i" /conf/.env
fi
if [ "$TRUSTED_PROXIES" != '' ]; then
    sed -i "s|TRUSTED_PROXIES=.*|TRUSTED_PROXIES=${TRUSTED_PROXIES}|i" /conf/.env
fi
if [ "$PHP_TZ" != '' ]; then
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/8.2/cli/php.ini
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/8.2/fpm/php.ini
fi
