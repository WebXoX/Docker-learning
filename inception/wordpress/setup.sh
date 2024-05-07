#!/bin/sh
if [ ! -d /var/www/ ]; then
    mkdir -p /var/www/
fi

curl -L https://wordpress.org/latest.tar.gz | tar -xzf - --directory /var/www/
cd /var/www/wordpress

if [ ! -f ./wp-config.php ]; then
    cp ./wp-config-sample.php ./wp-config.php
    sed -i "s|database_name_here|${DB_NAME}|g" ./wp-config.php
    sed -i "s|username_here|${DB_USER}|g" ./wp-config.php
    sed -i "s|password_here|${DB_PASS}|g" ./wp-config.php
    sed -i "s|localhost|mariadb|g" ./wp-config.php
fi

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install wordpress and create the admin and user
sleep 5
wp core install  --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$ADM_USER" --admin_password="$ADM_PASS" --admin_email="$ADM_EMAIL"
wp user create "$WP_USER" "$WP_USER_EMAIL" --role=subscriber --user_pass="$WP_USER_PASS" 

# Run the php-fpm daemon
php-fpm -FR