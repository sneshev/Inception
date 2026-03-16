FROM debian:bookworm

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \ 
    && apt-get install --no-install-recommends -y \ 
    tzdata \ 
    mariadb-server
    