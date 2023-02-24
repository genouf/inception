#!/bin/sh

# Faire un healthcheck pour attendre que le service mariadb soit up
sleep 12

if [ ! -e /var/www/wordpress/wp-config.php ]; then
	echo "Configuring wordpress..."
	echo "${MYSQL_DATABASE}<->${MYSQL_USER}<->${MYSQL_PASSWORD}"
	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb --path='/var/www/wordpress'
sleep 4
wp core install     --url=$WEBSITE_N --title=$SITE_T --admin_user=$ADM_U --admin_password=$ADM_P --admin_email=$ADM_E --allow-root --path='/var/www/wordpress'
wp user create      --allow-root --role=author $FIRST_L $FIRST_M --user_pass=$FIRST_P --path='/var/www/wordpress' >> /log.txt
fi

/usr/sbin/php-fpm7.3 -F