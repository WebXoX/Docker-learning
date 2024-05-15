#!/bin/sh

echo "[i] mysqld not found, creating...."
mkdir /var/run/mysqld
chmod 777 /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf


# if [ ! -d /var/lib/mysql/mysql ]; then
echo "[i] MySQL data directory not found, creating initial DBs"
chown -R mysql:mysql /var/lib/mysql
# mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

mysql_install_db --user=mysql --datadir=/var/lib/mysql
tfile=`mktemp`
# if ! [ -d "/var/lib/mysql/wordpress" ]; then
cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
/usr/bin/mysqld --user=mysql --bootstrap  < $tfile
rm -f $tfile
# fi

# exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@
# USE mysql;
# FLUSH PRIVILEGES ;
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
# CREATE DATABASE '$MYSQL_DATABASE';
# GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '$MYSQL_USER'@'%';
# CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '$MYSQL_USER'@'%';
# FLUSH PRIVILEGES ;