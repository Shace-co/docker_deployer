FROM php:8.1-fpm



# Set working directory
WORKDIR /var/www

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
RUN git clone "https://${GITHUB_PAT}@github.com/3x1io/shace-api" /var/www/app



RUN echo $(ls -1 /tmp/dir)

# Copy composer.lock and composer.json
# COPY composer.lock composer.json /var/www/

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
COPY ./.env /var/www/app/.env
# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN chown -R www:www /var/www/app
RUN chmod -R 755 /var/www/app
# Copy existing application directory contents
# COPY . /var/www

# Copy existing application directory permissions
# COPY --chown=www:www . /var/www

# Change current user to www
USER www

WORKDIR /var/www/app

RUN composer install
RUN npm install

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
