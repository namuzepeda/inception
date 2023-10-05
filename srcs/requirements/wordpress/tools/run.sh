#!/bin/bash

	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen =9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
	chown -R www-data:www-data /var/www/*;
	chown -R 755 /var/www/*;
	mkdir -p /run/php/;
	touch /run/php/php7.3-fpm.pid;

# Verificar si existe una instalación de WordPress en /var/www/html
if [ -d "/var/www/html/wp-config.php" ]; then
  echo "Ya existe una instalación de WordPress en /var/www/html."
  exit 1
fi

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

sudo mkdir -p /var/www/html

cd /var/www/html
wp core download --allow-root

wp config create --allow-root \
  --dbhost="$MYSQL_HOST" \
  --dbname="$MYSQL_DATABASE" \
  --dbuser="$MYSQL_USER" \
  --dbpass="$MYSQL_PASSWORD"

wp core install --allow-root \
  --url="$WP_URL" \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN_LOGIN" \
  --admin_password="$WP_ADMIN_PASSWORD" \
  --admin_email="$WP_ADMIN_EMAIL"

# Crear un usuario de prueba
wp user create --allow-root \
  "$WP_USER_LOGIN" \
  "$WP_USER_EMAIL" \
  --user_pass="$WP_USER_PASSWORD"

echo "WordPress se ha instalado correctamente en /var/www/html."

exec "$@"