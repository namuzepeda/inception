#!/bin/bash

set -eux

DIRECTORY_DATABASE=/var/lib/mysql/wordpress

echo "TEST-0"

if [ ! -d "$DIRECTORY_DATABASE" ]; then

	echo "TEST1"
	
	echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" | sudo mysql -u root

	echo "TEST2"

	echo $?

	echo "ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" | sudo mysql -u root

	echo $?

	echo "CREATE USER '${MYSQL_USER}'@'%'IDENTIFIED BY '${MYSQL_PASSWORD}';" | sudo mysql -u root

	echo $?

	echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" | sudo mysql -u root

	echo $?
	
	echo "FLUSH PRIVILEGES;" | sudo mysql -u root

	echo $?

	echo "FINISH"

fi

killall mysqld 2> /dev/null


exec "$@"