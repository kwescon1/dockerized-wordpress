#!/bin/sh

WP_PATH="/var/www/wordpress"
CONFIG_FILE="$WP_PATH/wp-config.php"
SAMPLE_CONFIG_FILE="$WP_PATH/wp-config-sample.php"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "WordPress not found in $WP_PATH - copying now..."
    if [ "$(ls -A $WP_PATH)" ]; then
        echo "WARNING: $WP_PATH is not empty - aborting copy"
    else
        cp -a /var/www/wordpress_backup/. $WP_PATH/
        echo "WordPress copied to $WP_PATH"

        # Copy wp-config-sample.php to wp-config.php
        cp $SAMPLE_CONFIG_FILE $CONFIG_FILE

        # Edit wp-config.php using sed
        sed -i "s/'database_name_here'/getenv('WORDPRESS_DB_NAME')/g" $CONFIG_FILE
        sed -i "s/'username_here'/getenv('WORDPRESS_DB_USER')/g" $CONFIG_FILE
        sed -i "s/'password_here'/getenv('WORDPRESS_DB_PASSWORD')/g" $CONFIG_FILE
        sed -i "s/'localhost'/getenv('WORDPRESS_DB_HOST')/g" $CONFIG_FILE

        # Add define('FS_METHOD', 'direct'); between the specified comments
        sed -i "/\/\* Add any custom values between this line and the \"stop editing\" line. \*\//a \
        define('FS_METHOD', 'direct');\
        " $CONFIG_FILE

        echo "$CONFIG_FILE has been updated"
    fi
else
    echo "Using existing WordPress in $WP_PATH"
fi

# Continue with normal fpm start
exec docker-php-entrypoint php-fpm
