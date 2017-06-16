FROM php:7-fpm

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

RUN apt-get update \
    && apt-get -y install git zip

COPY wordpress/composer.json composer.json
ONBUILD COMPOSER_ALLOW_SUPERUSER=1 composer install --no-interaction

WORKDIR /var/www/wordpress