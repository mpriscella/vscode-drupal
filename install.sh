#!/bin/sh

# Install Drupal.
drush site-install --site-name='Drupal Sandbox' --db-url=mysql://root:root@mysql:3306/drupal --account-name=admin --account-pass=admin

# Disable asset preprocessing.
drush -y config-set system.performance css.preprocess 0
drush -y config-set system.performance js.preprocess 0

# Install extensions.
yq read config.yml "modules.enable[*]" | while read p; do drush -y pm:enable "$p"; done
yq read config.yml "themes.enable[*]" | while read p; do drush -y theme:enable "$p"; done

# Rebuild cache.
drush cr
