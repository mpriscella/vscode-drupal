#!/bin/bash

sudo rm -rf /var/www/html

sudo git clone https://git.drupalcode.org/project/drupal.git /var/www/html

sudo chown -R vscode:root /var/www/html

cat > /var/www/html/.gitignore <<- EOM
vendor
modules
profiles
themes
sites/default/files
EOM

cd /var/www/html

composer install

composer require drush/drush
