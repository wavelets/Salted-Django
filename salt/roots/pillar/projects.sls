project:
  - name: django1
    base: /home/vagrant/django1/django1
    venv: /home/vagrant/django1/.venv
    module: django1.wsgi:application
    dbname: django1DB
    dbuser: dj1user
    dbpasswd: somereallylongpasswordgoeshere
    dbengine: django.db.backends.postgresql_psycopg2
    dbhost: localhost
    dbport: 5432
