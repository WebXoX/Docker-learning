FROM alpine:3.18.5
RUN apk update && apk add openrc && apk add mariadb mariadb-client  && apk add nano
RUN mkdir -p /usr/share/webapps/
EXPOSE 3306
# https://wiki.alpinelinux.org/wiki/MariaDB
mkdir -p /run/mysqld
mysqld -u root --data=./data &> /dev/null &
mysql_install_db