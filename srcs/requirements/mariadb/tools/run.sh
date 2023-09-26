#!/bin/bash

set -eux

DIRECTORY_DATABASE=/var/lib/mysql/wordpress

if [ ! -d "$DIRECTORY_DATABASE" ]; then
	echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" | mysql -u root

	echo "ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" | mysql -u root

	echo "CREATE USER '${MYSQL_USER}'@'%'IDENTIFIED BY '${MYSQL_PASSWORD}';" | mysql -u root
	echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" | mysql -u root
	
	echo "FLUSH PRIVILEGES;" | mysql -u root

fi

killall mysqld 2> /dev/null


exec "$@"