# #!/bin/sh

# echo "[i] mysqld not found, creating...."
# mkdir /var/run/mysqld
# chmod 777 /var/run/mysqld
# chown -R mysql:mysql /var/run/mysqld

# sed -i "s/#bind-address=.*/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf
# sed -i "s/skip-networking.*/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf

# echo "[i] MySQL data directory not found, creating initial DBs"
# chown -R mysql:mysql /var/lib/mysql

# mysql_install_db --user=mysql --datadir=/var/lib/mysql

# tfile=`mktemp`
# cat << EOF > $tfile
# USE mysql;
# FLUSH PRIVILEGES;
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
# CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
# GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
# FLUSH PRIVILEGES;
# EOF

# /usr/bin/mysqld --user=mysql --bootstrap < $tfile
# rm -f $tfile
#!bin/sh

chown -R mysql:mysql /var/lib/mysql

mkdir /var/run/mysqld
chmod 777 /var/run/mysqld

# allow mariadb to accept remote conections and set mariadb to listen for any network interface
sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf

# initialize the database
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# create the .sql file to create the database
cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# run the file .sql to create the database
/usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
rm -f /tmp/create_db.sql
