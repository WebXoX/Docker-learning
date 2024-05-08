#!/bin/sh

mkdir -p /run/mysqld
chmod 777 /var/run/mysqld

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
mysql_install_db --user=mysql --datadir=/var/lib/mysql

cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES ;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
CREATE DATABASE '$MYSQL_DATABASE';
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES ;
EOF

/usr/bin/mysqld --user=mysql --bootstrap <  /tmp/create_db.sql
	rm -f  /tmp/create_db.sql