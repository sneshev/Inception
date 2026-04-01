FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
		nginx \
		openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/nginx/sites-enabled/default && \
	rm -f /etc/nginx/sites-available/default && \
	rm -f /etc/nginx/conf.d/*.conf

COPY inception.conf /etc/nginx/conf.d/inception.conf

COPY entrypoint.sh /
RUN chmod 555 "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]