FROM alpine:3.7
LABEL authors="AEG"
RUN apk add --update nginx \
        bash \
  	supervisor \
	php7 \
        php7-fpm

RUN mkdir -p /run/nginx \
    && rm -v /etc/nginx/nginx.conf
RUN mkdir -p /run/php/ \ 
  && rm -v /etc/php7/php-fpm.conf \
  && rm -v /etc/php7/php-fpm.d/www.conf

ADD tools/ci/config/php/php-fpm.conf /etc/php7/
ADD tools/ci/config/php/pool.d/www.conf /etc/php7/php-fpm.d/
COPY /html /app
COPY ./version_*.html /app
WORKDIR /app
#ADD html /var/www/html

COPY ./tools/ci/config/supervisord/supervisord.ini /etc/supervisor.d/supervisord.ini
COPY ./tools/ci/config/nginx/snippets/fastcgi-php.conf /etc/nginx/snippets/
COPY ./tools/ci/config/nginx/nginx.conf /etc/nginx
EXPOSE 8888

CMD supervisord -c /etc/supervisor.d/supervisord.ini

