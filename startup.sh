#!/bin/bash

if [ ! -f "srcs/.env" ]; then
	cat < "srcs/.env.example" > "srcs/.env"
fi

set -a
source srcs/.env
set +a

for var in \
	WORDPRESS_URL \
	DATABASE_NAME \
	DB_USER_NAME \
	DB_USER_PASS \
	DB_ROOT_PASS \
	WP_ADMIN_USER \
	WP_ADMIN_PASS \
	WP_ADMIN_EMAIL
do
	if [ -z "${!var}" ]; then
		echo "Error: $var is empty"
		exit 1
	fi
done

if [[ ! "$DATABASE_NAME" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Error: invalid database name"
    echo "Database name should only contain letters, numbers, and underscores"
    exit 1
fi

echo "Environment is ok"


if ! command -v docker; then
	echo "Installing docker and docker-compose"
	apt update -y
	apt install -y docker.io
	apt install -y docker-compose
fi

if [ -f "srcs/.env.example" ]; then
	rm "srcs/.env.example"
fi
