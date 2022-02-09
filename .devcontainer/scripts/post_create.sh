#!/bin/bash

if [ ! -f /home/vscode.ssh/id_rsa ];then
  mkdir -p /home/vscode/.ssh
  echo -e "$DRUPAL_SSH_PRIVATE_KEY\n" > /home/vscode/.ssh/id_rsa
  chmod 400 /home/vscode/.ssh/id_rsa
fi
