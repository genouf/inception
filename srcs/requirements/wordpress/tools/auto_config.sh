#!/bin/sh

sleep 10
if [ ! -e /var/www/wordpress/wp-config.php ]; then
	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

/usr/sbin/php-fpm7.3 -F