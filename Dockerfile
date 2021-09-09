ARG drupal_version=latest

FROM drupal:${drupal_version}

# Copy library scripts to execute
COPY .devcontainer/library-scripts/*.sh .devcontainer/library-scripts/*.env /tmp/library-scripts/

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=groupnine
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
  && apt-get -y install --no-install-recommends lynx \
  && usermod -aG www-data ${USERNAME} \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Docker.
RUN apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release; \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg; \
  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null; \
  apt-get update && apt-get install -y docker-ce-cli

RUN pecl install xdebug; docker-php-ext-enable xdebug;

ENV COMPOSER_MEMORY_LIMIT=-1
ENV XDEBUG_MODE=debug
ENV XDEBUG_CONFIG="client_host=localhost log=/var/www/html/production/xdebug.log"

RUN apt-get update -y; \
  apt-get install -y git default-mysql-client patchutils; \
  mkdir web/modules/dev; \
  mkdir web/themes/dev;

COPY --from=mikefarah/yq:3 /usr/bin/yq /usr/local/bin/

COPY config.yml .

RUN sed -i 's/minimum-stability": "stable"/minimum-stability": "dev"/' composer.json

RUN composer require $(yq read config.yml composer.require[*] | tr '\r\n' ' ') -W

COPY . .
