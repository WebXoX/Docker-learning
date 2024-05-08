FROM alpine:3.18
RUN apk update  
RUN apk add --no-cache php php-fpm php-mysqli  php-phar php-curl curl  
# && rm -f /var/cache/apk/*

RUN mkdir -p /var/www/
RUN curl -L https://wordpress.org/latest.tar.gz | tar -xzf - --directory /var/www/
RUN rm /var/www/wordpress/wp-config-sample.php 
ADD ./setup.sh .
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod +x setup.sh
RUN sh setup.sh && rm setup.sh
EXPOSE 9000
CMD ["php-fpm81","-FR"]
