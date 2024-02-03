#!/bin/bash
function replace_or_insert() {
    # Voodoo magic: https://superuser.com/a/976712
    grep -q "^${1}=" /conf/.env && sed "s/^${1}=.*/${1}=${2}/" -i /conf/.env || sed "$ a\\${1}=${2}" -i /conf/.env
}

if [ "$APP_NAME" != '' ]; then
    replace_or_insert "APP_NAME" "$APP_NAME"
  fi
if [ "$APP_ENV" != '' ]; then
    replace_or_insert "APP_ENV" "$APP_ENV"
 fi
if [ "$APP_DEBUG" != '' ]; then
    replace_or_insert "APP_DEBUG" "$APP_DEBUG"
 fi
if [ "$APP_URL" != '' ]; then
    replace_or_insert "APP_URL" "$APP_URL"
 fi
if [ "$APP_FORCE_HTTPS" != '' ]; then
    replace_or_insert "APP_FORCE_HTTPS" "$APP_FORCE_HTTPS"
 fi
if [ "$APP_DIR" != '' ]; then
    replace_or_insert "APP_DIR" "$APP_DIR"
 fi
if [ "$DEBUGBAR_ENABLED" != '' ]; then
    replace_or_insert "DEBUGBAR_ENABLED" "$DEBUGBAR_ENABLED"
 fi
if [ "$LEGACY_V4_REDIRECT" != '' ]; then
    replace_or_insert "LEGACY_V4_REDIRECT" "$LEGACY_V4_REDIRECT"
 fi
if [ "$DB_OLD_LYCHEE_PREFIX" != '' ]; then
    replace_or_insert "DB_OLD_LYCHEE_PREFIX" "$DB_OLD_LYCHEE_PREFIX"
 fi
if [ "$DB_CONNECTION" != '' ]; then
    replace_or_insert "DB_CONNECTION" "$DB_CONNECTION"
 fi
if [ "$DB_HOST" != '' ]; then
    replace_or_insert "DB_HOST" "$DB_HOST"
 fi
if [ "$DB_PORT" != '' ]; then
    replace_or_insert "DB_PORT" "$DB_PORT"
 fi
if [ "$DB_DATABASE" != '' ]; then
    replace_or_insert "DB_DATABASE" "$DB_DATABASE"
 fi
if [ "$DB_USERNAME" != '' ]; then
    replace_or_insert "DB_USERNAME" "$DB_USERNAME"
 fi
if [ "$DB_PASSWORD" != '' ]; then
    replace_or_insert "DB_PASSWORD" "$DB_PASSWORD"
 elif [ "$DB_PASSWORD_FILE" != '' ]; then
    value=$(<$DB_PASSWORD_FILE)
    replace_or_insert "DB_PASSWORD" "$value"
 fi
if [ "$DB_LOG_SQL" != '' ]; then
    replace_or_insert "DB_LOG_SQL" "$DB_LOG_SQL"
 fi
if [ "$DB_LOG_SQL_EXPLAIN" != '' ]; then
    replace_or_insert "DB_LOG_SQL_EXPLAIN" "$DB_LOG_SQL_EXPLAIN"
 fi
if [ "$TIMEZONE" != '' ]; then
    replace_or_insert "TIMEZONE" "${TIMEZONE//\//\\\/}"
 fi
if [ "$ENABLE_TOKEN_AUTH" != '' ]; then
    replace_or_insert "ENABLE_TOKEN_AUTH" "$ENABLE_TOKEN_AUTH"
 fi
if [ "$CACHE_DRIVER" != '' ]; then
    replace_or_insert "CACHE_DRIVER" "$CACHE_DRIVER"
 fi
if [ "$SESSION_DRIVER" != '' ]; then
    replace_or_insert "SESSION_DRIVER" "$SESSION_DRIVER"
 fi
if [ "$SESSION_LIFETIME" != '' ]; then
    replace_or_insert "SESSION_LIFETIME" "$SESSION_LIFETIME"
 fi
if [ "$QUEUE_CONNECTION" != '' ]; then
    replace_or_insert "QUEUE_CONNECTION" "$QUEUE_CONNECTION"
 fi
if [ "$SECURITY_HEADER_HSTS_ENABLE" != '' ]; then
    replace_or_insert "SECURITY_HEADER_HSTS_ENABLE" "$SECURITY_HEADER_HSTS_ENABLE"
 fi
if [ "$SECURITY_HEADER_CSP_CONNECT_SRC" != '' ]; then
    replace_or_insert "SECURITY_HEADER_CSP_CONNECT_SRC" "$SECURITY_HEADER_CSP_CONNECT_SRC"
 fi
if [ "$SECURITY_HEADER_SCRIPT_SRC_ALLOW" != '' ]; then
    replace_or_insert "SECURITY_HEADER_SCRIPT_SRC_ALLOW" "$SECURITY_HEADER_SCRIPT_SRC_ALLOW"
 fi
if [ "$SESSION_SECURE_COOKIE" != '' ]; then
    replace_or_insert "SESSION_SECURE_COOKIE" "$SESSION_SECURE_COOKIE"
 fi
# if [ "$REDIS_SCHEME" != '' ]; then
#     sed -i "s|REDIS_SCHEME=.*|REDIS_SCHEME=${REDIS_SCHEME}|i" /conf/.env
# fi
# if [ "$REDIS_PATH" != '' ]; then
#     sed -i "s|REDIS_PATH=.*|REDIS_PATH=${REDIS_PATH}|i" /conf/.env
# fi
# if [ "$REDIS_HOST" != '' ]; then
#     sed -i "s|REDIS_HOST=.*|REDIS_HOST=${REDIS_HOST}|i" /conf/.env
# fi
# if [ "$REDIS_PORT" != '' ]; then
#     sed -i "s|REDIS_PORT=.*|REDIS_PORT=${REDIS_PORT}|i" /conf/.env
# fi
# if [ "$REDIS_PASSWORD" != '' ]; then
#     sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=${REDIS_PASSWORD}|i" /conf/.env
# elif [ "$REDIS_PASSWORD_FILE" != '' ]; then
#     value=$(<$REDIS_PASSWORD_FILE)
#     sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=${value}|i" /conf/.env
# fi
if [ "$MAIL_DRIVER" != '' ]; then
    replace_or_insert "MAIL_DRIVER" "$MAIL_DRIVER"
fi
if [ "$MAIL_HOST" != '' ]; then
    replace_or_insert "MAIL_HOST" "$MAIL_HOST"
fi
if [ "$MAIL_PORT" != '' ]; then
    replace_or_insert "MAIL_PORT" "$MAIL_PORT"
fi
if [ "$MAIL_USERNAME" != '' ]; then
    replace_or_insert "MAIL_USERNAME" "$MAIL_USERNAME"
fi
if [ "$MAIL_PASSWORD" != '' ]; then
    replace_or_insert "MAIL_PASSWORD" "$MAIL_PASSWORD"
elif [ "$MAIL_PASSWORD_FILE" != '' ]; then
    value=$(<$MAIL_PASSWORD_FILE)
    replace_or_insert "MAIL_PASSWORD" "$value"
fi
if [ "$MAIL_ENCRYPTION" != '' ]; then
    replace_or_insert "MAIL_ENCRYPTION" "$MAIL_ENCRYPTION"
fi
if [ "$MAIL_FROM_NAME" != '' ]; then
    replace_or_insert "MAIL_FROM_NAME" "$MAIL_FROM_NAME"
fi
if [ "$MAIL_FROM_ADDRESS" != '' ]; then
    replace_or_insert "MAIL_FROM_ADDRESS" "$MAIL_FROM_ADDRESS"
fi
if [ "$TRUSTED_PROXIES" != '' ]; then
    replace_or_insert "TRUSTED_PROXIES" "$TRUSTED_PROXIES"
fi
if [ "$PHP_TZ" != '' ]; then
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/8.2/cli/php.ini
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/8.2/fpm/php.ini
fi
