# PHP
FROM php:7.1-fpm

RUN apt-get update
RUN apt-get install -y autoconf pkg-config libssl-dev

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libxml2-dev \
        && docker-php-ext-install bcmath

RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini

COPY ./ /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN cd /var/www/html && composer install --quiet

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ['/bin/bash', '/entrypoint.sh']
