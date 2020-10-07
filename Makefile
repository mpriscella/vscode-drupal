.PHONY: install
install:
	@drush site-install --site-name='Drupal Sandbox' --db-url=mysql://root:root@mysql:3306/drupal --account-name=admin --account-pass=admin
	@drush -y config-set system.performance css.preprocess 0
	@drush -y config-set system.performance js.preprocess 0

