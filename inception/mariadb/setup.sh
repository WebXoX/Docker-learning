#!/bin/sh

echo "[i] mysqld not found, creating...."
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# if [ ! -d /var/lib/mysql/mysql ]; then
echo "[i] MySQL data directory not found, creating initial DBs"
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
tfile=`mktemp`
if [ ! -f "$tfile" ]; then
	return 1
fi
# if [! -f]
cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
rm -f $tfile
# fi
    # only run if we have a starting MYSQL_DATABASE env variable AND
    # the /docker-entrypoint-initdb.d/ file is not empty
# execute any pre-exec scripts
for i in /scripts/pre-exec.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-exec.d - processing $i"
		. ${i}
	fi
done

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@
# USE mysql;
# FLUSH PRIVILEGES ;
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
# CREATE DATABASE '$MYSQL_DATABASE';
# GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '$MYSQL_USER'@'%';
# CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '$MYSQL_USER'@'%';
# FLUSH PRIVILEGES ;