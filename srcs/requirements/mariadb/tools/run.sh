#!/bin/bash

set -eux

DIRECTORY_DATABASE=/var/run/mysqld/wordpress

if [ ! -d "$DIRECTORY_DATABASE" ]; then
		/usr/bin/mysqld_safe --datadir=/var/run/mysqld &
	until mysqladmin ping &>/dev/null; do
		sleep 1
	done
    
	mysql -u root << EOF
	
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

	DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DELETE FROM mysql.user WHERE user='';

	CREATE USER '${MYSQL_USER}'@'%'IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
	
	FLUSH PRIVILEGES;

EOF
	killall mysqld 2> /dev/null
fi


exec "$@"