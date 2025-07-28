# Dockerfile

FROM php:8.2

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    zip \
    sqlite3 \
    libsqlite3-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    curl \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo pdo_sqlite zip gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy Laravel project files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --no-dev --optimize-autoloader
RUN mkdir -p /var/www/database && touch /var/www/database/database.sqlite

# Create .env file (duplicate from .env.example)
RUN cp .env.example .env

# Generate app key
RUN php artisan key:generate

# Expose port 8080 for Render
EXPOSE 8080

# Serve the application
CMD php -S 0.0.0.0:8080 -t public