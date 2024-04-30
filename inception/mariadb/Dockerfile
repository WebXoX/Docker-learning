FROM alpine:3.18
RUN apk update && apk add openrc && apk add mysql mysql-client mariadb-server-utils
RUN mkdir -p /var/lib/mysql/data
RUN chown -R mysql:mysql /var/lib/mysql/data
USER mysql

# RUN mysqld --initialize-insecure --user=root --basedir=/usr/bin/mysql --datadir=/var/lib/mysql/data < /tmp/maria_init.sql
# RUN rm /tmp/maria_init.sql  # Remove temporary initialization script

EXPOSE 3306
CMD ["/usr/bin/mysqld", "--skip-log-error"]

# https://wiki.alpinelinux.org/wiki/MariaDB
# mkdir -p /run/mysqld
# mysqld -u root --data=./data &> /dev/null &
# mysql_install_db