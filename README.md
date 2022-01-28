# Visual Studio Code - Drupal Development Container

This repository provides a Visual Studio Code development container for the
Drupal framework.

This container does not currently mount any local codebases, it uses docker
volumes for [improved disk performance](https://code.visualstudio.com/docs/remote/containers-advanced#_improving-container-disk-performance)
and therefore all development must happen within the container.


## Quickstart

* Build and open this repository in a development container using the
[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
* Navigate to http://localhost:8080 in your browser to install Drupal.


## Install Drupal with Default Values

* Open a new terminal in Visual Studio Code and run `./install.sh`.
* Navigate to `http://localhost:8080` in your browser and log in to the Drupal
  instance with the username and password `admin`.


## Codespaces

`$DRUPAL_SSH_PRIVATE_KEY` env variable required.


## Developing Documentation

https://www.drupal.org/docs/develop/git/using-git-to-contribute-to-drupal/creating-an-interdiff

https://www.drupal.org/docs/develop/git/using-git-to-contribute-to-drupal/patch-and-merge-request-guidelines

https://www.drupal.org/docs/develop/git/using-git-to-contribute-to-drupal/making-a-patch

https://www.drupal.org/docs/system-requirements/php-requirements




# TODO

- [ ] For some reason, `apache2ctl start` works when starting a codespace after stopped, but results in a 502 gateway error if rebuilding
