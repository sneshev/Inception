FROM debian:bookworm

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
	apt-get install --no-install-recommends -y \
		php \
		php-mysqli \
		wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


WORKDIR /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v5.4.2/adminer-5.4.2.php -O index.php

COPY entrypoint.sh /
RUN chmod 555 "/entrypoint.sh"

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]