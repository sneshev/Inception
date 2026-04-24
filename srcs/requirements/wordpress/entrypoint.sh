#!/bin/bash

MAXCOUNT=60


DBHOST=mariadb
echo "Waiting for MariaDB..."

count=0
while ! mysqladmin ping -h"$DBHOST" -u"$DB_USER_NAME" -p"$DB_USER_PASS" --silent; do
	count=$((count + 1))
	if [ "$count" -ge "$MAXCOUNT" ]; then
		echo "Couldn't reach MariaDB. Exiting.."
		exit 1
	fi
	sleep 1
done

echo "Connected to MariaDB"

if [ ! -f wp-config.php ]; then
	echo "Creating wp-config.php..."
	wp config create \
		--dbname="$DATABASE_NAME" \
		--dbuser="$DB_USER_NAME" \
		--dbpass="$DB_USER_PASS" \
		--dbhost="$DBHOST" \
		--allow-root
	sed -i "s/listen =.*/listen = 9000/g"  /etc/php/8.2/fpm/pool.d/www.conf

	echo "Installing WordPress..."
	wp core install \
		--url="https://$WORDPRESS_URL" \
		--title="Inception Wordpress" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASS" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root
fi

echo "Starting php-fpm8.2.."
exec "$@"