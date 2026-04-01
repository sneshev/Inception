FROM debian:bookworm

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        tzdata \
        mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && \
    chown mysql /run/mysqld

COPY entrypoint.sh /
RUN chmod 555 "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mysqld", "--user=mysql","--bind-address=0.0.0.0"]