#!/bin/sh

# Install Drupal.
drush site-install --site-name='Drupal Sandbox' --db-url=mysql://root:root@mysql:3306/drupal --account-name=admin --account-pass=admin

# Disable asset preprocessing.
drush -y config-set system.performance css.preprocess 0
drush -y config-set system.performance js.preprocess 0

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

if [ "$CODESPACES" = 'true' ]
then
  echo "\$settings['reverse_proxy'] = TRUE;" >> web/sites/default/settings.php
  echo "\$settings['reverse_proxy_addresses'] = ['172.18.0.1', '172.18.0.3'];" >> web/sites/default/settings.php
fi

# Rebuild cache.
drush cr
