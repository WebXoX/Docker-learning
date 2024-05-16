#!/bin/sh
cd var/www/
if [ ! -f ./wp-config.php ]; then
    cp ./wp-config-sample.php ./wp-config.php
    sed -i "s|database_name_here|${MYSQL_DATABASE}|g" ./wp-config.php
    sed -i "s|username_here|${MYSQL_USER}|g" ./wp-config.php
    sed -i "s|password_here|${MYSQL_PASSWORD}|g" ./wp-config.php
    sed -i "s|localhost|mariadb|g" ./wp-config.php
fi
# if ![  -f ./wp-config.php ]; then
#     wp core config --dbhost=${MYSQL_HOST} --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --allow-root
    # wp core install --url=${DOMAIN_NAME} --title=${TITLE} --admin_user=${ADM_USER} --admin_password=${ADM_PASS} --admin_email=${USER_ADMIN_EMAIL} --skip-email --allow-root
    # wp user create ${WP_USER} ${WP_USER_EMAIL} --allow-root --role=subscriber --user_pass=${WP_USER_PASS}
# fi