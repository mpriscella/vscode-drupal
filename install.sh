#!/bin/bash

# Install Drupal.
drush site-install --site-name='Drupal Sandbox' --db-url=mysql://root:root@mysql:3306/drupal --account-name=admin --account-pass=admin
chmod -R 777 web/sites/default/files

# Disable asset preprocessing.
drush -y config-set system.performance css.preprocess 0
drush -y config-set system.performance js.preprocess 0

if [ "$CODESPACES" = 'true' ]
then
  echo "\$settings['reverse_proxy'] = TRUE;" >> web/sites/default/settings.php
  echo "\$settings['reverse_proxy_addresses'] = [\$_SERVER['SERVER_ADDR'], \$_SERVER['REMOTE_ADDR']];" >> web/sites/default/settings.php
  mkdir -p /root/.ssh
  printf "$DRUPAL_SSH_PRIVATE_KEY\n" > /root/.ssh/id_rsa
  chmod 400 /root/.ssh/id_rsa
fi

git_protocol="$(yq read config.yml modules.git_protocol)"
if [ "$git_protocol" = 'ssh' ]
then
  remote_url="git@git.drupal.org:project/"
elif [ "$git_protocol" = 'https' ]
then
  remote_url="https://git.drupalcode.org/project/"
fi

# Clone projects.
yq read config.yml modules.clone[*] | while read -r p; do cd web/modules/dev && git clone "$remote_url/$p.git"; done
yq read config.yml themes.clone[*] | while read -r p; do cd web/themes/dev && git clone "$remote_url/$p.git"; done

# Install extensions.
yq read config.yml "modules.enable[*]" | while read -r p; do drush -y pm:enable "$p"; done
yq read config.yml "themes.enable[*]" | while read -r p; do drush -y theme:enable "$p"; done

# Rebuild cache.
drush cr
