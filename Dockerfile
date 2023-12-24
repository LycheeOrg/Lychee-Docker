FROM php:8.2-fpm-alpine as base

# Set version label
LABEL maintainer="lycheeorg"

# Environment variables
ENV PUID='1000'
ENV PGID='1000'
ENV USER='lychee'
ENV PHP_TZ=UTC

# Arguments
# To use the latest Lychee release instead of master pass `--build-arg TARGET=release` to `docker build`
ARG TARGET=dev
# To install composer development dependencies, pass `--build-arg COMPOSER_NO_DEV=0` to `docker build`
ARG COMPOSER_NO_DEV=1

# Install base dependencies, add user and group, clone the repo and install php libraries
RUN \
    apk update && \
    apk add --no-cache \
    nginx \
    php82 \
    php82-common \
    php82-fpm \
    php82-pdo \
    php82-opcache \
    php82-zip \
    php82-phar \
    php82-iconv \
    php82-cli \
    php82-curl \
    php82-gd \
    php82-bcmath \
    php82-session \
    php82-exif \
    php82-pecl-imagick \
    php82-openssl \
    php82-mbstring \
    php82-tokenizer \
    php82-fileinfo \
    php82-json \
    php82-xml \
    php82-xmlwriter \
    php82-simplexml \
    php82-dom \
    php82-pdo_mysql \
    php82-pdo_pgsql \
    php82-pdo_sqlite \
    php82-tokenizer \
    curl \
    exiftool \
    ffmpeg \
    git \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    libwebp \
    rsync \
    composer \
    unzip && \
    addgroup --gid "$PGID" "$USER" && \
    adduser -g '' -H -D -u "$PUID" -G "$USER" "$USER" && \
    cd /var/www/html && \
    if [ "$TARGET" = "release" ] ; then RELEASE_TAG="-b v$(curl -s https://raw.githubusercontent.com/LycheeOrg/Lychee/master/version.md)" ; fi && \
    git clone --depth 1 $RELEASE_TAG https://github.com/LycheeOrg/Lychee.git && \
    mv Lychee/.git/refs/heads/master Lychee/master || cp Lychee/.git/HEAD Lychee/master && \
    mv Lychee/.git/HEAD Lychee/HEAD && \
    rm -r Lychee/.git/* && \
    mkdir -p Lychee/.git/refs/heads && \
    mv Lychee/HEAD Lychee/.git/HEAD && \
    mv Lychee/master Lychee/.git/refs/heads/master && \
    echo "$TARGET" > /var/www/html/Lychee/docker_target && \
    cd /var/www/html/Lychee && \
    echo "Last release: $(cat version.md)" && \
    composer install --prefer-dist && \
    find . -wholename '*/[Tt]ests/*' -delete && \
    find . -wholename '*/[Tt]est/*' -delete && \
    rm -r storage/framework/cache/data/* 2> /dev/null || true && \
    rm    storage/framework/sessions/* 2> /dev/null || true && \
    rm    storage/framework/views/* 2> /dev/null || true && \
    rm    storage/logs/* 2> /dev/null || true && \
    chown -R www-data:www-data /var/www/html/Lychee && \
    echo "* * * * * www-data cd /var/www/html/Lychee && php artisan schedule:run >> /dev/null 2>&1" >> /etc/crontab && \
    apk del git composer && \
    apk cache clean && \
    rm -rf /var/lib/apt/lists/*

# Multi-stage build: Build static assets
# This allows us to not include Node within the final container
FROM node:20-alpine as node_modules_go_brrr

RUN mkdir -p  /app
WORKDIR /app
COPY --from=base /var/www/html/Lychee /app

# Use yarn or npm depending on what type of
# lock file we might find. Defaults to
# NPM if no lock file is found.
# Note: We run "production" for Mix and "build" for Vite
RUN if [ -f "vite.config.js" ]; then \
        ASSET_CMD="build"; \
    else \
        ASSET_CMD="production"; \
    fi; \
    if [ -f "yarn.lock" ]; then \
        yarn install --frozen-lockfile; \
        yarn $ASSET_CMD; \
    elif [ -f "pnpm-lock.yaml" ]; then \
        corepack enable && corepack prepare pnpm@latest-8 --activate; \
        pnpm install --frozen-lockfile; \
        pnpm run $ASSET_CMD; \
    elif [ -f "package-lock.json" ]; then \
        npm ci --no-audit; \
        npm run $ASSET_CMD; \
    else \
        npm install; \
        npm run $ASSET_CMD; \
    fi;

# From our base container created above, we
# create our final image, adding in static
# assets that we generated above
FROM base

# Packages like Laravel Nova may have added assets to the public directory
# or maybe some custom assets were added manually! Either way, we merge
# in the assets we generated above rather than overwrite them
COPY --from=node_modules_go_brrr /app/public /var/www/html/Lychee/public-npm
RUN rsync -ar /var/www/html/Lychee/public-npm/ /var/www/html/Lychee/public/ \
    && rm -rf /var/www/html/Lychee/public-npm \
    && chown -R www-data:www-data /var/www/html/Lychee/public

# Add custom Nginx configuration
COPY default.conf /etc/nginx/nginx.conf

EXPOSE 80
VOLUME /conf /uploads /sym /logs

WORKDIR /var/www/html/Lychee

COPY entrypoint.sh inject.sh /

RUN chmod +x /entrypoint.sh && \
    chmod +x /inject.sh && \
    if [ ! -e /run/php ] ; then mkdir /run/php ; fi

HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "nginx" ]
