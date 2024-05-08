FROM alpine:3.18
RUN apk update \
    &&  apk add mariadb \
    mariadb-client mariadb-server-utils 
ENV MYSQL_DATABASE=wordpressdb
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=42ABd
ENV MYSQL_ROOT_PASSWORD=42ABdadmin
EXPOSE 3306
ADD setup.sh .
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql  # Set ownership and permissions
RUN chmod -R 755 setup.sh
RUN sh setup.sh
RUN rm setup.sh


USER mysql
CMD ["/usr/bin/mysqld", "--skip-log-error"]

# RUN mysqld --initialize-insecure --user=root --basedir=/usr/bin/mysql --datadir=/var/lib/mysql/data < /tmp/maria_init.sql
# RUN rm /tmp/maria_init.sql  # Remove temporary initialization script
# https://wiki.alpinelinux.org/wiki/MariaDB
# mkdir -p /run/mysqld
# mysqld -u root --data=./data &> /dev/null &
# mysql_install_db