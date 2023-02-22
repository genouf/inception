#!/bin/sh

# This script is used to create the database and the user for the wordpress
service mysql start;
echo "lol1"
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" -p$MYSQL_ROOT_PASSWORD
echo "lol2"
mysql -e "CREATE USER IF NOT EXISTS ${MYSQL_USER}@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';" -p$MYSQL_ROOT_PASSWORD
echo "lol3"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -p$MYSQL_ROOT_PASSWORD
echo "lol4"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" -p$MYSQL_ROOT_PASSWORD
echo "lol5"
mysql -e "FLUSH PRIVILEGES;" -p$MYSQL_ROOT_PASSWORD
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
exec mysqld_safe