FROM php:8.1-fpm

# Set working directory
RUN mkdir -p /var/www/shace

RUN mkdir -p /var/www/shace/api

WORKDIR /var/www/shace/api

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential apt-utils \
    libpng-dev libjpeg62-turbo-dev libwebp-dev libfreetype6-dev \
    jpegoptim optipng pngquant gifsicle \
    libicu-dev \
    locales \
    vim \
    zip \ 
    unzip \
    libzip-dev \
    git \
    nodejs \
    npm \
    curl
    

# Git Clone
ARG GIT_PERSONAL_ACCESS_TOKEN

RUN git clone "https://${GIT_PERSONAL_ACCESS_TOKEN}@github.com/3x1io/shace-api" /var/www/shace/api

RUN echo $(ls -1 /tmp/dir)

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl fileinfo
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd
RUN docker-php-ext-configure intl 
RUN docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./.env /var/www/shace/api/.env

# Copy File Config
ADD ./www.conf /usr/local/etc/php-fpm.d/www.conf

# Add user for laravel application
RUN groupadd -g 1000 www

RUN useradd -u 1000 -ms /bin/bash -g www www

RUN chown -R www:www /var/www/shace/api

RUN chmod -R 755 /var/www/shace/api

# Change current user to www
USER www

WORKDIR /var/www/shace/api

RUN composer install

RUN npm install

# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["php-fpm"]
