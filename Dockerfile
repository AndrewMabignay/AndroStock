FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    zip unzip git curl sqlite3 libsqlite3-dev libzip-dev \
    libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_sqlite mbstring exif pcntl bcmath gd zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

RUN composer install --optimize-autoloader --no-dev

RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/www/database \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache /var/www/database

EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000