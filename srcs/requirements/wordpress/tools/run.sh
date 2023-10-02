#!/bin/bash

	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen =9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
	chown -R www-data:www-data /var/www/*;
	chown -R 755 /var/www/*;
	mkdir -p /run/php/;
	touch /run/php/php7.3-fpm.pid;

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "WordPress script starting..."
    mkdir -p /var/www/html
    echo "WordPress script: Downloading plugin..."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
    echo "WordPress script: Downloaded..."
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html;
    echo "WordPress script: Downloading WordPress Core..."
	wp core download --allow-root ;
    echo "WordPress script: Downloaded..."
	echo "WordPress plugin: creating users..."
	wp config create --allow-root --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb:3306 --path='/var/www/html'
	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --path='/var/www/html'
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --path='/var/www/html';
	echo "WordPress: set up!"
fi

exec "$@"