#!/bin/bash

if [ ! -f drupal/composer.json ]; then
  git submodule update --init
fi

sudo rm -rf /var/www/html
sudo ln -s $CODESPACE_VSCODE_FOLDER/drupal /var/www/html

cat > drupal/.gitignore <<- EOM
vendor
modules
profiles
themes
sites/default/files
EOM

cd $CODESPACE_VSCODE_FOLDER/drupal

composer install

composer require drush/drush
