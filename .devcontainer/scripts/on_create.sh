#!/bin/bash

if [ ! -f drupal/composer.json ]; then
  git submodule update --init
fi

cat > drupal/.gitignore <<- EOM
vendor
modules
profiles
themes
sites/default/files
EOM

cd $CODESPACE_VSCODE_FOLDER/drupal && \
  composer install && \
  composer require drush/drush
