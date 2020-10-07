ARG drupal_version=latest

FROM drupal:${drupal_version}

RUN apt-get update -y; \
  apt-get install -y git; \
  composer require drush/drush drupal/coder

COPY --from=mysql:8 /usr/bin/mysql /usr/local/bin/
COPY --from=docker /usr/local/bin/docker /usr/local/bin/

COPY . .
