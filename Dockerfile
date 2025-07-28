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

# ✅ Create .env before running any artisan commands
RUN cp .env.example .env

# ✅ Generate app key
RUN php artisan key:generate

# ✅ Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# ✅ Build front-end assets (Tailwind, Vite, etc.)
RUN npm install && npm run build

# ✅ Create SQLite database file
RUN mkdir -p database && touch database/database.sqlite

# ✅ Run migrations after .env and DB file exist
RUN php artisan migrate --force

# Expose port for Render
EXPOSE 8080

# Start Laravel app
CMD php -S 0.0.0.0:8080 -t public