#!/bin/bash

sudo rm -rf /var/www/html && sudo ln -s $CODESPACE_VSCODE_FOLDER/drupal /var/www/html

# apache2ctl start

mkdir -p /vscode/.ssh
echo -e "$DRUPAL_SSH_PRIVATE_KEY\n" > /vscode/.ssh/id_rsa
chmod 400 /vscode/.ssh/id_rsa
