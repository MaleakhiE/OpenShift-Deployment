# syntax=docker/dockerfile:1

# Use the official PHP image with Apache
FROM php:8.2-apache

# Set the working directory
WORKDIR /var/www/html

# Copy the application files into the container
COPY . .

# Install dependencies
RUN apt-get update && apt-get install -y libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql

# Copy the virtual host configuration
COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Enable mod_rewrite
RUN a2enmod rewrite

# Set permissions for storage and bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80
