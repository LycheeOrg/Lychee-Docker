#!/bin/bash
function replace_or_insert() {
    # Voodoo magic: https://superuser.com/a/976712
    grep -q "^${1}=" /conf/.env && sed "s|^${1}=.*|${1}=${2}|" -i /conf/.env || sed "$ a\\${1}=${2}" -i /conf/.env
}

if [ "$APP_NAME" != '' ]; then
    replace_or_insert "APP_NAME" "$APP_NAME"
 fi
if [ "$APP_ENV" != '' ]; then
    replace_or_insert "APP_ENV" "$APP_ENV"
 fi
if [ "$APP_KEY" != '' ]; then
    replace_or_insert "APP_KEY" "$APP_KEY"
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
if [ "$LIVEWIRE_ENABLED" != '' ]; then
    replace_or_insert "LIVEWIRE_ENABLED" "$LIVEWIRE_ENABLED"
 fi
if [ "$VUEJS_ENABLED" != '' ]; then
    replace_or_insert "VUEJS_ENABLED" "$VUEJS_ENABLED"
 fi
if [ "$LEGACY_API_ENABLED" != '' ]; then
    replace_or_insert "LEGACY_API_ENABLED" "$LEGACY_API_ENABLED"
 fi
if [ "$LOG_VIEWER_ENABLED" != '' ]; then
    replace_or_insert "LOG_VIEWER_ENABLED" "$LOG_VIEWER_ENABLED"
 fi
if [ "$S3_ENABLED" != '' ]; then
    replace_or_insert "S3_ENABLED" "$S3_ENABLED"
 fi
if [ "$LEGACY_V4_REDIRECT" != '' ]; then
    replace_or_insert "LEGACY_V4_REDIRECT" "$LEGACY_V4_REDIRECT"
 fi
if [ "$PHOTO_PIPES" != '' ]; then
    replace_or_insert "PHOTO_PIPES" "$PHOTO_PIPES"
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
if [ "$DB_LIST_FOREIGN_KEYS" != '' ]; then
    replace_or_insert "DB_LIST_FOREIGN_KEYS" "$DB_LIST_FOREIGN_KEYS"
 fi
if [ "$TIMEZONE" != '' ]; then
    replace_or_insert "TIMEZONE" "$TIMEZONE"
 fi
if [ "$LYCHEE_IMAGE_VISIBILITY" != '' ]; then
    replace_or_insert "LYCHEE_IMAGE_VISIBILITY" "$LYCHEE_IMAGE_VISIBILITY"
 fi
if [ "$LYCHEE_UPLOADS" != '' ]; then
    replace_or_insert "LYCHEE_UPLOADS" "$LYCHEE_UPLOADS"
 fi
if [ "$LYCHEE_DIST" != '' ]; then
    replace_or_insert "LYCHEE_DIST" "$LYCHEE_DIST"
 fi
if [ "$LYCHEE_SYM" != '' ]; then
    replace_or_insert "LYCHEE_SYM" "$LYCHEE_SYM"
 fi
if [ "$LYCHEE_UPLOADS_URL" != '' ]; then
    replace_or_insert "LYCHEE_UPLOADS_URL" "$LYCHEE_UPLOADS_URL"
 fi
if [ "$LYCHEE_DIST_URL" != '' ]; then
    replace_or_insert "LYCHEE_DIST_URL" "$LYCHEE_DIST_URL"
 fi
if [ "$LYCHEE_SYM_URL" != '' ]; then
    replace_or_insert "LYCHEE_SYM_URL" "$LYCHEE_SYM_URL"
 fi
if [ "$ENABLE_TOKEN_AUTH" != '' ]; then
    replace_or_insert "ENABLE_TOKEN_AUTH" "$ENABLE_TOKEN_AUTH"
 fi
if [ "$CACHE_DRIVER" != '' ]; then
    replace_or_insert "CACHE_DRIVER" "$CACHE_DRIVER"
 fi
if [ "$LOG_VIEWER_CACHE_DRIVER" != '' ]; then
    replace_or_insert "LOG_VIEWER_CACHE_DRIVER" "$LOG_VIEWER_CACHE_DRIVER"
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
if [ "$SECURITY_HEADER_CSP_FRAME_ANCESTORS" != '' ]; then
    replace_or_insert "SECURITY_HEADER_CSP_FRAME_ANCESTORS" "$SECURITY_HEADER_CSP_FRAME_ANCESTORS"
 fi 
if [ "$SESSION_SECURE_COOKIE" != '' ]; then
    replace_or_insert "SESSION_SECURE_COOKIE" "$SESSION_SECURE_COOKIE"
 fi
if [ "$REDIS_URL" != '' ]; then
    replace_or_insert "REDIS_URL" "$REDIS_URL"
 fi
if [ "$REDIS_PATH" != '' ]; then
    replace_or_insert "REDIS_PATH" "$REDIS_PATH"
 fi
if [ "$REDIS_HOST" != '' ]; then
    replace_or_insert "REDIS_HOST" "$REDIS_HOST"
 fi
if [ "$REDIS_PORT" != '' ]; then
    replace_or_insert "REDIS_PORT" "$REDIS_PORT"
 fi
if [ "$REDIS_USERNAME" != '' ]; then
    replace_or_insert "REDIS_USERNAME" "$REDIS_USERNAME"
 fi
if [ "$REDIS_PASSWORD" != '' ]; then
    replace_or_insert "REDIS_PASSWORD" "$REDIS_PASSWORD"
elif [ "$REDIS_PASSWORD_FILE" != '' ]; then
    value=$(<$REDIS_PASSWORD_FILE)
    replace_or_insert "REDIS_PASSWORD" "$value"
fi
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
if [ "$SKIP_DIAGNOSTICS_CHECKS" != '' ]; then
    replace_or_insert "SKIP_DIAGNOSTICS_CHECKS" "$SKIP_DIAGNOSTICS_CHECKS"
 fi
if [ "$VITE_PUSHER_APP_KEY" != '' ]; then
    replace_or_insert "VITE_PUSHER_APP_KEY" "$VITE_PUSHER_APP_KEY"
 fi
if [ "$VITE_PUSHER_APP_CLUSTER" != '' ]; then
    replace_or_insert "VITE_PUSHER_APP_CLUSTER" "$VITE_PUSHER_APP_CLUSTER"
 fi
if [ "$AMAZON_SIGNIN_CLIENT_ID" != '' ]; then
    replace_or_insert "AMAZON_SIGNIN_CLIENT_ID" "$AMAZON_SIGNIN_CLIENT_ID"
 fi
if [ "$AMAZON_SIGNIN_SECRET" != '' ]; then
    replace_or_insert "AMAZON_SIGNIN_SECRET" "$AMAZON_SIGNIN_SECRET"
 fi
if [ "$AMAZON_SIGNIN_REDIRECT_URI" != '' ]; then
    replace_or_insert "AMAZON_SIGNIN_REDIRECT_URI" "$AMAZON_SIGNIN_REDIRECT_URI"
 fi
if [ "$APPLE_CLIENT_ID" != '' ]; then
    replace_or_insert "APPLE_CLIENT_ID" "$APPLE_CLIENT_ID"
 fi
if [ "$APPLE_CLIENT_SECRET" != '' ]; then
    replace_or_insert "APPLE_CLIENT_SECRET" "$APPLE_CLIENT_SECRET"
 fi
if [ "$APPLE_REDIRECT_URI" != '' ]; then
    replace_or_insert "APPLE_REDIRECT_URI" "$APPLE_REDIRECT_URI"
 fi
if [ "$FACEBOOK_CLIENT_ID" != '' ]; then
    replace_or_insert "FACEBOOK_CLIENT_ID" "$FACEBOOK_CLIENT_ID"
 fi
if [ "$FACEBOOK_CLIENT_SECRET" != '' ]; then
    replace_or_insert "FACEBOOK_CLIENT_SECRET" "$FACEBOOK_CLIENT_SECRET"
 fi
if [ "$FACEBOOK_REDIRECT_URI" != '' ]; then
    replace_or_insert "FACEBOOK_REDIRECT_URI" "$FACEBOOK_REDIRECT_URI"
 fi
if [ "$GITHUB_CLIENT_ID" != '' ]; then
    replace_or_insert "GITHUB_CLIENT_ID" "$GITHUB_CLIENT_ID"
 fi
if [ "$GITHUB_CLIENT_SECRET" != '' ]; then
    replace_or_insert "GITHUB_CLIENT_SECRET" "$GITHUB_CLIENT_SECRET"
 fi
if [ "$GITHUB_REDIRECT_URI" != '' ]; then
    replace_or_insert "GITHUB_REDIRECT_URI" "$GITHUB_REDIRECT_URI"
 fi
if [ "$GOOGLE_CLIENT_ID" != '' ]; then
    replace_or_insert "GOOGLE_CLIENT_ID" "$GOOGLE_CLIENT_ID"
 fi
if [ "$GOOGLE_CLIENT_SECRET" != '' ]; then
    replace_or_insert "GOOGLE_CLIENT_SECRET" "$GOOGLE_CLIENT_SECRET"
 fi
if [ "$GOOGLE_REDIRECT_URI" != '' ]; then
    replace_or_insert "GOOGLE_REDIRECT_URI" "$GOOGLE_REDIRECT_URI"
 fi
if [ "$MASTODON_DOMAIN" != '' ]; then
    replace_or_insert "MASTODON_DOMAIN" "$MASTODON_DOMAIN"
 fi
if [ "$MASTODON_ID" != '' ]; then
    replace_or_insert "MASTODON_ID" "$MASTODON_ID"
 fi
if [ "$MASTODON_SECRET" != '' ]; then
    replace_or_insert "MASTODON_SECRET" "$MASTODON_SECRET"
 fi
if [ "$MASTODON_REDIRECT_URI" != '' ]; then
    replace_or_insert "MASTODON_REDIRECT_URI" "$MASTODON_REDIRECT_URI"
 fi
if [ "$MICROSOFT_CLIENT_ID" != '' ]; then
    replace_or_insert "MICROSOFT_CLIENT_ID" "$MICROSOFT_CLIENT_ID"
 fi
if [ "$MICROSOFT_CLIENT_SECRET" != '' ]; then
    replace_or_insert "MICROSOFT_CLIENT_SECRET" "$MICROSOFT_CLIENT_SECRET"
 fi
if [ "$MICROSOFT_REDIRECT_URI" != '' ]; then
    replace_or_insert "MICROSOFT_REDIRECT_URI" "$MICROSOFT_REDIRECT_URI"
 fi
if [ "$NEXTCLOUD_CLIENT_ID" != '' ]; then
    replace_or_insert "NEXTCLOUD_CLIENT_ID" "$NEXTCLOUD_CLIENT_ID"
 fi
if [ "$NEXTCLOUD_CLIENT_SECRET" != '' ]; then
    replace_or_insert "NEXTCLOUD_CLIENT_SECRET" "$NEXTCLOUD_CLIENT_SECRET"
 fi
if [ "$NEXTCLOUD_REDIRECT_URI" != '' ]; then
    replace_or_insert "NEXTCLOUD_REDIRECT_URI" "$NEXTCLOUD_REDIRECT_URI"
 fi
if [ "$NEXTCLOUD_BASE_URI" != '' ]; then
    replace_or_insert "NEXTCLOUD_BASE_URI" "$NEXTCLOUD_BASE_URI"
 fi
if [ "$KEYCLOAK_CLIENT_ID" != '' ]; then
    replace_or_insert "KEYCLOAK_CLIENT_ID" "$KEYCLOAK_CLIENT_ID"
 fi
if [ "$KEYCLOAK_CLIENT_SECRET" != '' ]; then
    replace_or_insert "KEYCLOAK_CLIENT_SECRET" "$KEYCLOAK_CLIENT_SECRET"
 fi
if [ "$KEYCLOAK_REDIRECT_URI" != '' ]; then
    replace_or_insert "KEYCLOAK_REDIRECT_URI" "$KEYCLOAK_REDIRECT_URI"
 fi
if [ "$KEYCLOAK_BASE_URL" != '' ]; then
    replace_or_insert "KEYCLOAK_BASE_URL" "$KEYCLOAK_BASE_URL"
 fi
if [ "$KEYCLOAK_REALM" != '' ]; then
    replace_or_insert "KEYCLOAK_REALM" "$KEYCLOAK_REALM"
 fi
if [ "$AUTHELIA_BASE_URL" != '' ]; then
    replace_or_insert "AUTHELIA_BASE_URL" "$AUTHELIA_BASE_URL"
 fi
if [ "$AUTHELIA_CLIENT_ID" != '' ]; then
    replace_or_insert "AUTHELIA_CLIENT_ID" "$AUTHELIA_CLIENT_ID"
 fi
if [ "$AUTHELIA_CLIENT_SECRET" != '' ]; then
    replace_or_insert "AUTHELIA_CLIENT_SECRET" "$AUTHELIA_CLIENT_SECRET"
 fi
if [ "$AUTHELIA_REDIRECT_URI" != '' ]; then
    replace_or_insert "AUTHELIA_REDIRECT_URI" "$AUTHELIA_REDIRECT_URI"
 fi
if [ "$AUTHENTIK_BASE_URL" != '' ]; then
    replace_or_insert "AUTHENTIK_BASE_URL" "$AUTHENTIK_BASE_URL"
 fi
if [ "$AUTHENTIK_CLIENT_ID" != '' ]; then
    replace_or_insert "AUTHENTIK_CLIENT_ID" "$AUTHENTIK_CLIENT_ID"
 fi
if [ "$AUTHENTIK_CLIENT_SECRET" != '' ]; then
    replace_or_insert "AUTHENTIK_CLIENT_SECRET" "$AUTHENTIK_CLIENT_SECRET"
 fi
if [ "$AUTHENTIK_REDIRECT_URI" != '' ]; then
    replace_or_insert "AUTHENTIK_REDIRECT_URI" "$AUTHENTIK_REDIRECT_URI"
 fi
if [ "$AWS_ACCESS_KEY_ID" != '' ]; then
    replace_or_insert "AWS_ACCESS_KEY_ID" "$AWS_ACCESS_KEY_ID"
 fi
if [ "$AWS_SECRET_ACCESS_KEY" != '' ]; then
    replace_or_insert "AWS_SECRET_ACCESS_KEY" "$AWS_SECRET_ACCESS_KEY"
 fi
if [ "$AWS_DEFAULT_REGION" != '' ]; then
    replace_or_insert "AWS_DEFAULT_REGION" "$AWS_DEFAULT_REGION"
 fi
if [ "$AWS_BUCKET" != '' ]; then
    replace_or_insert "AWS_BUCKET" "$AWS_BUCKET"
 fi
if [ "$AWS_URL" != '' ]; then
    replace_or_insert "AWS_URL" "$AWS_URL"
 fi
if [ "$AWS_ENDPOINT" != '' ]; then
    replace_or_insert "AWS_ENDPOINT" "$AWS_ENDPOINT"
 fi
if [ "$AWS_IMAGE_VISIBILITY" != '' ]; then
    replace_or_insert "AWS_IMAGE_VISIBILITY" "$AWS_IMAGE_VISIBILITY"
 fi
if [ "$AWS_USE_PATH_STYLE_ENDPOINT" != '' ]; then
    replace_or_insert "AWS_USE_PATH_STYLE_ENDPOINT" "$AWS_USE_PATH_STYLE_ENDPOINT"
 fi
if [ "$PHP_TZ" != '' ]; then
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/8.4/cli/php.ini
    sed -i "s|;*date.timezone =.*|date.timezone = ${PHP_TZ}|i" /etc/php/8.4/fpm/php.ini
 fi
if [ "$VITE_HTTP_PROXY_ENABLED" != '' ]; then
    replace_or_insert "VITE_HTTP_PROXY_ENABLED" "$VITE_HTTP_PROXY_ENABLED"
 fi