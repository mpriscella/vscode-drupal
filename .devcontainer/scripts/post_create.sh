#!/bin/bash

sudo rm -rf /var/www/html && sudo ln -s $CODESPACE_VSCODE_FOLDER/drupal /var/www/html

mkdir -p /vscode/.ssh
echo -e "$DRUPAL_SSH_PRIVATE_KEY\n" > /home/vscode/.ssh/id_rsa
chmod 400 /home/vscode/.ssh/id_rsa
