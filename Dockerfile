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

# Copy all files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Create SQLite database file
RUN mkdir -p /var/www/database && touch /var/www/database/database.sqlite

# Create .env file and generate key
RUN cp .env.example .env && php artisan key:generate

# Run migrations
RUN php artisan migrate --force

# ✅ Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# ✅ Install Node dependencies and build assets
RUN npm install && npm run build

# ✅ Copy Vite build output to public/build
RUN mkdir -p public/build && cp -r build/* public/build/

# ✅ (Optional) Laravel cache boost
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Expose port for Render
EXPOSE 8080

# Serve the app
CMD php -S 0.0.0.0:8080 -t public