#!/bin/bash

sudo rm -rf /var/www/html

sudo git clone https://git.drupalcode.org/project/drupal.git /var/www/html

sudo chown -R vscode:root /var/www/html

echo "vendor\nmodules\nprofiles\nthemes" > /var/www/html/.gitignore

cd /var/www/html

composer install

composer require drush/drush
