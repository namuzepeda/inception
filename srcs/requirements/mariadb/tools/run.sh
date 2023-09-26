#!/bin/bash

set -eux

DIRECTORY_DATABASE=/var/lib/mysql/wordpress

if [ ! -d "$DIRECTORY_DATABASE" ]; then
		/usr/bin/mysqld_safe --datadir=/var/lib/mysql &
	until mysqladmin ping &>/dev/null; do
		sleep 1
	done

	#mysql command is a client for connecting and communicating with the
	#the MYSQL database.
	#-u root specifies that the client should connect as the root user,
	#which has admin privileges

	#ALTER USER is used to modify the properties of an existing user
	#in this case we are setting the password for the root user of the MYSQL instance
	
	#DELETE FROM lines are for security, the first one deletes all users from the MYSQL
	#instance except for the root
	#removes all root users that can connect from hosts other than localhost, 127.0.0.1, or ::1.
	#remove also all users where the user column is an empty string

	#then we create a a new user, and specify its password, this user can connect from any machine
	#on the network
	#we grant all privileges, meaning the user will be able to have full access to the database
	#and perform any action

	#flushing the privileges allows to reload the MSQL server's grant tables and update the in-memory
	#privileges with any changes made.
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