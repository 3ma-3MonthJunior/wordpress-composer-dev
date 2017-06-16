FROM php:7-fpm

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

RUN apt-get update \
    && apt-get -y install git zip libpng12-dev

RUN pecl install xdebug-2.5.0 \
	&& docker-php-ext-enable xdebug \
	&& docker-php-ext-install -j$(nproc) gd mysqli

COPY wordpress/composer.json composer.json
ONBUILD COMPOSER_ALLOW_SUPERUSER=1 composer install --no-interaction

WORKDIR /var/www/wordpress