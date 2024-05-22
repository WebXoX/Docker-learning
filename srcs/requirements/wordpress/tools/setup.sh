#!/bin/sh

# Create the directory to store the wordpress if not created
if [ ! -d /var/www/ ]; then
    mkdir -p /var/www/
fi
cd /var/www/

# Download the latest version of wordpress
curl -L https://wordpress.org/latest.tar.gz | tar -xzf - --directory /var/www/
cd ./wordpress

## Wordpress Setup
echo "[info] Setting up Wordpress"

echo "[info] installing wp-cli"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/bin/wp

if ! wp core is-installed 2>/dev/null; then
    cp ./wp-config-sample.php ./wp-config.php
    sed -i "s|database_name_here|${DB_NAME}|g" ./wp-config.php
    sed -i "s|username_here|${DB_USER}|g" ./wp-config.php
    sed -i "s|password_here|${DB_PASS}|g" ./wp-config.php
    sed -i "s|localhost|mariadb|g" ./wp-config.php
    echo "[info] installing wordpress files"
    wp core install --allow-root --url="$DOMAIN" --title="$TITLE" --admin_user="$ADM_USER" --admin_password="$ADM_PASS" --admin_email="$ADM_EMAIL"
    echo "[info] creating user $WP_USER"
    wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" --role=subscriber --user_pass="$WP_USER_PASS" 
else
    echo "[info] wp is already installed"
fi

echo "[info] changing ownership"
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "[info] Running PHP-FPM"
php-fpm81 -F