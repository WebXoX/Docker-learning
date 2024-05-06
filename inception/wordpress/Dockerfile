FROM alpine:3.18
RUN apk update  
RUN apk add --no-cache php php-fpm php-mysqli  php-phar php-curl curl  openrc 
RUN mkdir -p /var/www/
RUN curl -L https://wordpress.org/latest.tar.gz | tar -xzf - --directory /var/www/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN env
# RUN wp core install  --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$ADM_USER" --admin_password="$ADM_PASS" --admin_email="$ADM_EMAIL"
# RUN wp user create "$WP_USER" "$WP_USER_EMAIL" --role=subscriber --user_pass="$WP_USER_PASS" 


EXPOSE 80

CMD ["env"]
