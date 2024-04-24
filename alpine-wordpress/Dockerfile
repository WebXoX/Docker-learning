FROM alpine:3.18.5
RUN apk update  
RUN apk add --no-cache php php-fpm php-mysqli curl
RUN mkdir -p /usr/share/webapps/

RUN curl -L https://wordpress.org/latest.tar.gz | tar -xzf - --directory /usr/share/webapps/
# RUN rm latest.tar.gz
# COPY wp-config.php /var/www/html/

EXPOSE 9000

CMD ["php-fpm"]
# RUN mkdir -p /usr/share/webapps/

# RUN # adduser -g 'Nginx www user' -h /home/www/ wwwcbz
# RUN  rc-update add nginx default
# RUN  rc-service nginx start