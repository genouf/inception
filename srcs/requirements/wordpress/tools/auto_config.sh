#!/bin/sh

# Faire un healthcheck pour attendre que le service mariadb soit up
sleep 10
rm -f /var/www/wordpress/wp-config.php

if [ ! -e /var/www/wordpress/wp-config.php ]; then
	echo "Configuring wordpress..."
	echo "${MYSQL_DATABASE}<->${MYSQL_USER}<->${MYSQL_PASSWORD}"
	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb --path='/var/www/wordpress'
# sleep 2
# wp core install     --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
# wp user create      --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log.txt
fi

/usr/sbin/php-fpm7.3 -F