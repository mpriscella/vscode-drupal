#!/bin/bash

sudo rm -rf /var/www/html && sudo ln -s $CODESPACE_VSCODE_FOLDER/drupal /var/www/html

# apache2ctl start
