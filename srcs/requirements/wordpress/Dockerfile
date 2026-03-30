FROM debian:bookworm

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
	    php8.2-fpm \
	    php8.2-mysql \
		mariadb-client \
    	ca-certificates \
		wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/wordpress-6.5.2.tar.gz -O wordpress.tar.gz && \
	tar -xvf wordpress.tar.gz && \
	rm wordpress.tar.gz && \
	mkdir -p /var/www/html && \
	chown -R www-data:www-data /var/www/html && \
	mv wordpress/* /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY --chmod=555 entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm8.2", "-F"]