FROM alpine:3.18
RUN apk update  
RUN apk add --no-cache php php-fpm php-mysqli  php-phar php-curl curl  php-mysqlnd && \
    rm -f /var/cache/apk/*
RUN mkdir -p /var/www/
RUN curl -L https://wordpress.org/latest.tar.gz | tar -xzf - --directory /var/www/
	# && \
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php81/php-fpm.d/www.conf && \   
        sed -i "s|;listen.owner = nobody|listen.owner = root|g" /etc/php81/php-fpm.d/www.conf && \
        sed -i "s|;listen.group = nobody|listen.group = root|g" /etc/php81/php-fpm.d/www.conf 
	# cp /var/www/wp-config-sample.php /var/www/wp-config.php 
ADD ./setup.sh .
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod +x setup.sh
RUN sh setup.sh && rm setup.sh
EXPOSE 9000
# CMD ["/bin/sh"]
CMD ["php-fpm81","-FR"]
