FROM debian:bullseye-slim

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

# Add User and Group
RUN \
    addgroup --gid "$PGID" "$USER" && \
    adduser --gecos '' --no-create-home --disabled-password --uid "$PUID" --gid "$PGID" "$USER"

# Install base dependencies, clone the repo and install php libraries
RUN \
    set -ev && \
    apt-get update && \
    apt-get install -qy \
    nginx-light \
    php7.4-mysql \
    php7.4-pgsql \
    php7.4-sqlite3 \
    php7.4-imagick \
    php7.4-mbstring \
    php7.4-json \
    php7.4-gd \
    php7.4-xml \
    php7.4-zip \
    php7.4-fpm \
    php7.4-redis \
    php7.4-bcmath \
    php7.4-intl \
    curl \
    libimage-exiftool-perl \
    ffmpeg \
    git \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    webp \
    composer && \
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
    composer install --no-dev --prefer-dist && \
    find . -wholename '*/[Tt]ests/*' -delete && \
    find . -wholename '*/[Tt]est/*' -delete && \
    rm -r storage/framework/cache/data/* 2> /dev/null || true && \
    rm    storage/framework/sessions/* 2> /dev/null || true && \
    rm    storage/framework/views/* 2> /dev/null || true && \
    rm    storage/logs/* 2> /dev/null || true && \
    chown -R www-data:www-data /var/www/html/Lychee && \
    apt-get purge -y --autoremove git composer && \
    rm -rf /var/lib/apt/lists/*

# Add custom Nginx configuration
COPY default.conf /etc/nginx/nginx.conf

EXPOSE 80
VOLUME /conf /uploads /sym

WORKDIR /var/www/html/Lychee

COPY entrypoint.sh inject.sh /

RUN chmod +x /entrypoint.sh && \
    chmod +x /inject.sh && \
    mkdir /run/php

HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "nginx" ]
