FROM php:7.0.4-fpm

COPY ./www /var/www

WORKDIR /var/www

RUN apt-get update -y && apt-get install -y zip unzip

RUN docker-php-ext-install pdo mbstring

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && php composer.phar install --no-dev --no-scripts \
    && rm composer.phar

RUN chmod -R 777 /var/www/storage \
        /var/www/bootstrap/cache

RUN php artisan key:generate
RUN php artisan config:clear
RUN php artisan config:cache
RUN php artisan optimize
