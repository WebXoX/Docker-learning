#!/bin/sh

# execute any pre-init scripts
for i in /scripts/pre-init.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-init.d - processing $i"
		. "${i}"
	fi
done

if [ -d "/run/mysqld" ]; then
	echo "[i] mysqld already present, skipping creation"
	chown -R mysql:mysql /run/mysqld
else
	echo "[i] mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "[i] MySQL directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "[i] MySQL data directory not found, creating initial DBs"

	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
	if [ "$DB_NAME" != "" ]; then
	    echo "[i] Creating database: $DB_NAME"
		echo "[i] with character set: 'utf8' and collation: 'utf8_general_ci'"
		echo "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
		if [ "$DB_USER" != "" ]; then
			echo "[i] Creating user: $DB_USER with password $DB_PASS"
			echo "GRANT ALL ON \`$DB_NAME\`.* to '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" >> $tfile
		fi
	fi

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
	rm -f $tfile

    # only run if we have a starting DB_NAME env variable AND
    # the /docker-entrypoint-initdb.d/ file is not empty
	if [ "$DB_NAME" != "" ] && [ "$(ls -A /docker-entrypoint-initdb.d 2>/dev/null)" ]; then

		# start the server temporarily so that we can import seed files
        echo
        echo "Preparing to process the contents of /docker-entrypoint-initdb.d/"
        echo
		TEMP_OUTPUT_LOG=/tmp/mysqld_output
		/usr/bin/mysqld --user=mysql --skip-name-resolve --skip-networking=0 --silent-startup > "${TEMP_OUTPUT_LOG}" 2>&1 &
		PID="$!"
	
		# watch the output log until the server is running
		until tail "${TEMP_OUTPUT_LOG}" | grep -q "Version:"; do
			sleep 0.2
		done

		# use mysql client to import seed files while temp db is running
		# use the starting DB_NAME so mysql knows where to import
		MYSQL_CLIENT="/usr/bin/mysql -u root -p$MYSQL_ROOT_PASSWORD"
		
        # loop through all the files in the seed directory
        # redirect input (<) from .sql files into the mysql client command line
        # pipe (|) the output of using `gunzip -c` on .sql.gz files
		for f in /docker-entrypoint-initdb.d/*; do
			case "$f" in
				*.sql)    echo "  $0: running $f"; eval "${MYSQL_CLIENT} ${DB_NAME} < $f"; echo ;;
				*.sql.gz) echo "  $0: running $f"; gunzip -c "$f" | eval "${MYSQL_CLIENT} ${DB_NAME}"; echo ;;
			esac
		done

    	# send the temporary mysqld server a shutdown signal
        # and wait till it's done before completeing the init process
    	kill -s TERM "${PID}"
    	wait "${PID}"
        rm -f TEMP_OUTPUT_LOG
    	echo "Completed processing seed files."
	fi;

	echo
	echo 'MySQL init process done. Ready for start up.'
	echo

	echo "exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0" "$@"
fi

# execute any pre-exec scripts
for i in /scripts/pre-exec.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-exec.d - processing $i"
		. ${i}
	fi
done

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@