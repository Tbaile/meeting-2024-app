#!/bin/sh
set -e

# This is the entrypoint for the docker container
# It is responsible for setting up the application
# More info on `ENTRYPOINT` and `CMD` can be found in the Docker documentation:
# https://docs.docker.com/reference/dockerfile/#entrypoint

# if first arg is `apache2-foreground` then setup application
if [ "$1" = 'apache2-foreground' ]; then
    # Wait until the database is ready
    wait-for "${DB_HOST}:${DB_PORT}" -t "${DB_TIMEOUT:-300}"
    # Migrate the database with laravel
    php artisan migrate --force
fi

exec "$@"
