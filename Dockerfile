ARG drupal_version=latest

FROM drupal:${drupal_version}

ENV COMPOSER_MEMORY_LIMIT=-1

RUN apt-get update -y; \
  apt-get install -y git; \
  mkdir web/modules/dev; \
  mkdir web/themes/dev;

COPY --from=mysql:8 /usr/bin/mysql /usr/local/bin/
COPY --from=docker /usr/local/bin/docker /usr/local/bin/
COPY --from=mikefarah/yq /usr/bin/yq /usr/local/bin/

COPY config.yml .

RUN composer require $(yq read config.yml composer.require[*] | tr '\r\n' ' ')

COPY . .
