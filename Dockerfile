# Starting from the official PHP 8 image with Apache
FROM php:8.3-apache
# Change the document root, for Laravel it's "public"
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
# Enable the Apache mod_rewrite module
RUN a2enmod rewrite
WORKDIR /var/www/html
# Install the required PHP extensions
RUN apt-get update \
    && apt-get install -y libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip
# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
# Copy the application files and install the dependencies
COPY . .
RUN chown -R www-data:www-data /var/www/html/storage \
    && composer install --no-dev
# Copy the entrypoint script and set up the default command
COPY --chmod=777 entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["apache2-foreground"]
