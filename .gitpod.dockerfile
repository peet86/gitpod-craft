FROM gitpod/workspace-full:latest

USER root

ENV NGINX_DOCROOT_IN_REPO="web"

# Group
RUN addgroup gitpod www-data

# PHP FPM 
RUN apt-get update \
 && apt-get -y install autossh \
 && apt-get -y install php7.4-fpm php7.4-cli php7.4-bz2 \
 && apt-get -y install php7.4-common php7.4-curl php7.4-gd php7.4-imagick php7.4-json php7.4-mbstring php7.4-mysql php7.4-zip php7.4-intl php7.4-xml\
 && apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/*

# Nginx config
COPY gitpod/nginx.conf /etc/nginx/nginx.conf

# PHP config
COPY gitpod/php.ini /etc/php/7.4/fpm/php.ini
COPY gitpod/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

# Allow gitpod group to edit php and nginx
RUN true \
	&& chown -R root:gitpod /etc/php \
	&& chmod -R g+rw /etc/php

RUN true \
    && chown -R root:gitpod /etc/nginx \
    && chmod -R g+rw /etc/nginx
