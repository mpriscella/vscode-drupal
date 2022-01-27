#!/bin/bash

sudo rm -rf /var/www/html

sudo git clone https://git.drupalcode.org/project/drupal.git /var/www/html

sudo chown -R vscode:vscode /var/www/html

# cd /var/www/html

echo "vendor\nmodules\nprofiles\nthemes" > /var/www/html/.gitignore

cd /home/vscode

composer require drush/drush

cd /var/www/html

# composer install

# composer install

# drush install

./bin/drush site-install --db-url=mysql://drupal:foundation@127.0.0.1:3306/drupal --existing-config --account-pass=admin
