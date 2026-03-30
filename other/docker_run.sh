#!/bin/bash

docker run -p 3306:3306 --name=mariadb --hostname=mariadb mariadb_image

#this is from mariadb github
# docker run -d \
	# --init-file=/initfile.sql \
	# my_mariadb
	# --volume [path-of-initfile.sql]:/docker-entrypoint-initdb.d \
	# --volume [data]:/var/lib/mysql \
