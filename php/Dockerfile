FROM php:8.0.16RC1-fpm-alpine3.15
#FROM php:7.4-fpm-alpine

# DEFINE DEPENDENCIES VARIABLES
ENV build_deps autoconf zlib-dev libsodium-dev freetype-dev libpng-dev libjpeg-turbo-dev libwebp-dev
ENV persistent_deps g++ gcc curl linux-headers make zlib freetype libpng libjpeg-turbo libsodium libwebp

# Install dependencies
RUN apk upgrade --update-cache --available && apk update && apk add --virtual .build-dependencies $build_deps
RUN apk add --update --virtual .persistent-dependencies $persistent_deps


# Configure php
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp 
RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && docker-php-ext-install -j${NPROC} gd
RUN docker-php-ext-install pdo pdo_mysql fileinfo exif sodium

# install and enable xdebug
# RUN apk add --no-cache $PHPIZE_DEPS && pecl install xdebug && docker-php-ext-enable xdebug

# Delete Dev Dependencies
RUN apk del -f .build-dependencies

# Copy File Config
ADD ./docker-compose/php/www.conf /usr/local/etc/php-fpm.d/www.conf

# ADD and set Group
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

# Create folder to run
RUN mkdir -p /var/www/html

# Set Profile
RUN chown laravel:laravel /var/www/html
RUN chmod 777 /var/www/html

# Work in the specific space
WORKDIR /var/www/html

