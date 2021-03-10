ARG drupal_version=latest

FROM drupal:${drupal_version}

RUN pecl install xdebug; docker-php-ext-enable xdebug;

ENV COMPOSER_MEMORY_LIMIT=-1
ENV XDEBUG_MODE=debug
ENV XDEBUG_CONFIG="client_host=localhost log=/var/www/html/production/xdebug.log"

RUN apt-get update -y; \
  apt-get install -y git default-mysql-client; \
  mkdir web/modules/dev; \
  mkdir web/themes/dev;

COPY --from=mikefarah/yq:3 /usr/bin/yq /usr/local/bin/

COPY config.yml .

RUN composer require $(yq read config.yml composer.require[*] | tr '\r\n' ' ')

COPY . .
