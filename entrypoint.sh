#!/bin/sh
set -e

# if first arg is `apache2-foreground` then setup application
if [ "$1" = 'apache2-foreground' ]; then
    # Here we just migrate the database
    php artisan migrate --force
fi

exec "$@"