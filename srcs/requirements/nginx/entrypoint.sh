#!/bin/bash
set -e

DOMAIN_NAME="sneshev.42.fr"
SSL_DIR="/etc/nginx/ssl"
mkdir -p "$SSL_DIR"

if [ ! -f "$SSL_DIR/$DOMAIN_NAME.crt" ] || [ ! -f "$SSL_DIR/$DOMAIN_NAME.key" ]; then
	echo "Generating self-signed certificate .."
	openssl req -x509 -nodes -days 365 \
		-subj "/CN=$DOMAIN_NAME" \
		-newkey rsa:2048 \
		-out "$SSL_DIR/$DOMAIN_NAME.crt" \
		-keyout "$SSL_DIR/$DOMAIN_NAME.key"

	chmod 644 "$SSL_DIR/$DOMAIN_NAME.crt"
	chmod 600 "$SSL_DIR/$DOMAIN_NAME.key"

	sed -i "s|\$DOMAIN_NAME|$DOMAIN_NAME|g" /etc/nginx/conf.d/inception.conf
	sed -i "s|\$SSL_DIR|$SSL_DIR|g" /etc/nginx/conf.d/inception.conf
fi

echo "Starting NGINX.."
exec "$@"