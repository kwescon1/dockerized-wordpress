#!/bin/sh

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "WordPress not found in /var/www/wordpress - copying now..."
    if [ "$(ls -A /var/www/wordpress)" ]; then
        echo "WARNING: /var/www/wordpress is not empty - aborting copy"
    else
        cp -a /var/www/wordpress_backup/. /var/www/wordpress/
        echo "WordPress copied to /var/www/wordpress"
    fi
else
    echo "Using existing WordPress in /var/www/wordpress"
fi

# Continue with normal fpm start
exec docker-php-entrypoint php-fpm
