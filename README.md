As of Dec 29, 2013 17:34 PM PST

	.:
	salt  Vagrantfile

	./salt:
	roots

	./salt/roots:
	minion  minion.pem  minion.pub  pillar  salt

	./salt/roots/pillar:
	packages.sls  pip-packages.sls  ppas.sls  projects.sls  top.sls  virtualenvs.sls

	./salt/roots/salt:
	django-projects  pip-packages  ppas   top.sls  virtualenvs
	packages         postgresql    redis  uwsgi

	./salt/roots/salt/django-projects:
	django-settings.py  init.sls  nginx-project.conf  uwsgi.ini

	./salt/roots/salt/packages:
	init.sls

	./salt/roots/salt/pip-packages:
	init.sls

	./salt/roots/salt/postgresql:
	init.sls

	./salt/roots/salt/ppas:
	init.sls

	./salt/roots/salt/redis:

	./salt/roots/salt/uwsgi:
	init.sls  uwsgi.conf

	./salt/roots/salt/virtualenvs:
	django1-requirements.txt  init.sls

