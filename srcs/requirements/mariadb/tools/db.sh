#!/bin/sh

# Start the MySQL service
service mariadb start

# Wait for MySQL to start
while ! mysqladmin ping -hlocalhost -u$MYSQL_USER -p$MYSQL_PASSWORD --silent; do
    sleep 1
done

# Create the user and grant privileges
sudo mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create the database
sudo mysql -e "CREATE DATABASE $MYSQL_DATABASE;"

# Stop the MySQL service
service mariadb stop

# Start the MySQL service in the background (as a daemon)
mysqld
