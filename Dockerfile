# Starting from the official PHP 8 image with Apache
FROM php:8.3-apache
# Change the document root, for Laravel it's "public"
# source: https://hub.docker.com/_/php/
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
# Enable the Apache mod_rewrite module
RUN a2enmod rewrite
# Install the required software and PHP extensions
RUN apt-get update \
    && apt-get install -y netcat-openbsd libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip
# Copy composer binary from the official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
# ADD works differently than COPY, more info here: https://docs.docker.com/reference/dockerfile/#add
ADD --checksum=sha256:206a8f9b2177703fc5aa924d85ad6c72e82413e2d09635b4c9c82a1b65b5b3d5 \
    --chmod=777 \
    https://raw.githubusercontent.com/eficode/wait-for/v2.2.4/wait-for /usr/local/bin/wait-for
# Change working directory to the application root
WORKDIR /var/www/html
# Copy the application files and install the dependencies
COPY . .
RUN chown -R www-data:www-data /var/www/html/storage \
    && composer install --no-dev
# Copy the entrypoint script and set up the default command
COPY --chmod=777 entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["apache2-foreground"]
