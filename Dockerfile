ARG drupal_version=latest

FROM drupal:${drupal_version}

ENV COMPOSER_MEMORY_LIMIT=-1

RUN apt-get update -y; \
  apt-get install -y git;

COPY --from=mysql:8 /usr/bin/mysql /usr/local/bin/
COPY --from=docker /usr/local/bin/docker /usr/local/bin/
COPY --from=mikefarah/yq /usr/bin/yq /usr/local/bin/

COPY config.yml .

RUN yq read config.yml composer.require[*] | while read p; do composer require "$p"; done
RUN mkdir web/modules/dev; yq read config.yml modules.clone[*] | while read p; do cd web/modules/dev && git clone "https://git.drupalcode.org/project/$p.git"; done
RUN mkdir web/themes/dev; yq read config.yml themes.clone[*] | while read p; do cd web/themes/dev && git clone "https://git.drupalcode.org/project/$p.git"; done

COPY . .
