FROM debian:bookworm-slim as base

# Set version label
LABEL maintainer="lycheeorg"

# Environment variables
ENV PUID='1000'
ENV PGID='1000'
ENV USER='lychee'
ENV PHP_TZ=UTC

# Arguments
# To use the latest Lychee release instead of master pass `--build-arg TARGET=release` to `docker build`
ARG TARGET=nightly
# To install composer development dependencies, pass `--build-arg COMPOSER_NO_DEV=0` to `docker build`
ARG COMPOSER_NO_DEV=1
# To use another branch instead of master pass `--build-arg BRANCH=some-branch` to `docker build`
# This is NOT compatible with the release target above
ARG BRANCH=master

# Install base dependencies, add user and group, clone the repo and install php libraries
RUN \
    set -ev && \
    [ "$TARGET" != "release" -o "$BRANCH" = "master" ] && \
    apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy --no-install-recommends\
    adduser \
    nginx-light \
    php8.2-mysql \
    php8.2-pgsql \
    php8.2-sqlite3 \
    php8.2-imagick \
    php8.2-mbstring \
    php8.2-gd \
    php8.2-xml \
    php8.2-zip \
    php8.2-fpm \
    php8.2-redis \
    php8.2-bcmath \
    php8.2-intl \
    curl \
    libimage-exiftool-perl \
    ffmpeg \
    git \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    webp \
    cron \
    composer \
    unzip && \
    addgroup --gid "$PGID" "$USER" && \
    adduser --gecos '' --no-create-home --disabled-password --uid "$PUID" --gid "$PGID" "$USER" && \
    cd /var/www/html && \
    if [ "$TARGET" = "release" ] ; then RELEASE_TAG="-b v$(curl -s https://raw.githubusercontent.com/LycheeOrg/Lychee/master/version.md)" ; \
    elif [ "$BRANCH" != "master" ] ; then RELEASE_TAG="-b $BRANCH" ; fi && \
    git clone --depth 1 $RELEASE_TAG https://github.com/LycheeOrg/Lychee.git && \
    mv Lychee/.git/refs/heads/$BRANCH Lychee/$BRANCH || cp Lychee/.git/HEAD Lychee/$BRANCH && \
    mv Lychee/.git/HEAD Lychee/HEAD && \
    rm -r Lychee/.git/* && \
    mkdir -p Lychee/.git/refs/heads && \
    mv Lychee/HEAD Lychee/.git/HEAD && \
    mv Lychee/$BRANCH Lychee/.git/refs/heads/$BRANCH && \
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
    apt-get purge -y --autoremove git composer && \
    apt-get clean -qy &&\
    rm -rf /var/lib/apt/lists/*

# Multi-stage build: Build static assets
# This allows us to not include Node within the final container
FROM node:20 as static_builder

RUN mkdir /app

RUN mkdir -p  /app
WORKDIR /app
COPY --from=base /var/www/html/Lychee /app

RUN \
    npm ci --no-audit && \
    npm run build

# Get the static assets built in the previous step
FROM base
COPY --from=static_builder --chown=www-data:www-data /app/public /var/www/html/Lychee/public

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
