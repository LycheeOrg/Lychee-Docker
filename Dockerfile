FROM debian:bookworm-slim AS base

# Set version label
LABEL maintainer="lycheeorg"

# Environment variables
ENV PUID='1000'
ENV PGID='1000'
ENV PHP_TZ=UTC

# Arguments
# To use the latest Lychee release instead of master pass `--build-arg TARGET=release` to `docker build`
ARG TARGET=nightly
# To install composer development dependencies, pass `--build-arg COMPOSER_NO_DEV=0` to `docker build`
ARG COMPOSER_NO_DEV=1
# To use another branch instead of master pass `--build-arg BRANCH=some-branch` to `docker build`
# This is NOT compatible with the release target above
ARG BRANCH=master

# https://stackoverflow.com/questions/53377176/change-imagemagick-policy-on-a-dockerfile (for the sed on policy.xml)
# Install base dependencies, add user and group, clone the repo and install php libraries
RUN \
    set -ev && \
    [ "$TARGET" != "release" -o "$BRANCH" = "master" ] && \
    apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy --no-install-recommends\
    ca-certificates \
    curl \
    apt-transport-https && \
    curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb && \
    dpkg -i /tmp/debsuryorg-archive-keyring.deb && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php.list' && \
    apt-get update && \
    apt-get install -qy --no-install-recommends \
    adduser \
    nginx-light \
    php8.4-mysql \
    php8.4-pgsql \
    php8.4-sqlite3 \
    php8.4-imagick \
    php8.4-mbstring \
    php8.4-gd \
    php8.4-xml \
    php8.4-zip \
    php8.4-fpm \
    php8.4-redis \
    php8.4-bcmath \
    php8.4-intl \
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
    ghostscript \
    unzip && \
    cd /var/www/html && \
    sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml && \
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
    usermod -o -u "$PUID" "www-data" && \
    groupmod -o -g "$PGID" "www-data" && \
    chown -R www-data:www-data /var/www/html/Lychee && \
    chmod -R g+ws storage/image-jobs || true && \
    chmod -R g+ws storage/livewire-tmp || true && \
    chmod -R g+ws storage/lychee-tmp || true && \
    echo "* * * * * www-data cd /var/www/html/Lychee && php artisan schedule:run >> /dev/null 2>&1" >> /etc/crontab && \
    apt-get purge -y --autoremove git composer && \
    apt-get clean -qy && \
    rm -rf /var/lib/apt/lists/*

# Multi-stage build: Build static assets
# This allows us to not include Node within the final container
FROM node:20 AS static_builder

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
VOLUME /conf /uploads /sym /logs /lychee-tmp

WORKDIR /var/www/html/Lychee

COPY entrypoint.sh inject.sh /

RUN chmod +x /entrypoint.sh && \
    chmod +x /inject.sh && \
    if [ ! -e /run/php ] ; then mkdir /run/php ; fi

HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "nginx" ]
