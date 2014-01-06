include:
    - virtualenvs
    - postgresql
    - uwsgi
    - packages

{% for item in pillar.get('project', []) %}

nginx:
  service:
    - running
    - enable: True
    - watch:
        - file: enable-nginx-site-{{ item.name}}
        - file: default-nginx

default-nginx:
  file.absent:
    - name: /etc/nginx/sites-enabled/default
    - require_in:
        - service: nginx


nginx-conf-{{ item.name}}:
  file.managed:
    - name: /etc/nginx/sites-available/{{ item.name}}.conf
    - source: salt://django-projects/nginx-project.conf
    - template: jinja
    - owner: www-data
    - group: www-data
    - mode: 755
    - context:
        name: {{ item.name }}
    - require_in:
        - service: nginx

enable-nginx-site-{{ item.name }}:
  file.symlink:
    - name: /etc/nginx/sites-enabled/{{ item.name }}.conf
    - target: /etc/nginx/sites-available/{{ item.name }}.conf
    - force: false
    - require: 
        - file: nginx-conf-{{ item.name }}

/etc/uwsgi/apps-available/{{ item.name }}.ini:
  file.managed:
    - source: salt://django-projects/uwsgi.ini
    - template: jinja
    - user: www-data
    - group: www-data
    - mode: 755
    - context:
        venv: {{ item.venv }}
        base: {{ item.base }}
        module: {{ item.module }}
        name: {{ item.name }}

/etc/postgresql/9.3/main/pg_hba.conf:
  file.managed:
    - source: salt://django-projects/pg_hba.conf
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 640
    - context:
        dbuser: {{ item.dbuser }}
        dbname: {{ item.dbname }}

enable-uwsgi-app-{{ item.name }}:
  file.symlink:
    - name: /etc/uwsgi/apps-enabled/{{ item.name }}.ini
    - target: /etc/uwsgi/apps-available/{{ item.name }}.ini
    - force: false

djangouser-{{ item.dbuser }}:
    postgres_user.present:
        - name: {{ item.dbuser }}
        - password: {{ item.dbpasswd }}
        - user: postgres
        - require:
            - service: postgresql

djangodb:
    postgres_database.present:
        - name: {{ item.dbname }}
        - encoding: UTF8
        - lc_ctype: en_US.UTF8
        - lc_collate: en_US.UTF8
        - template: template0
        - owner: {{ item.dbuser }}
        - user: postgres
        - require:
            - postgres_user: djangouser-{{ item.dbuser }}

/home/vagrant/{{ item.name }}:
  file.directory:
    - user: vagrant
    - group: vagrant
    - makedirs: True
    - recurse:
        - user
        - group

create Django project:
  cmd.run:
    - user: vagrant
    - name: ". .venv/bin/activate && django-admin.py startproject  {{ item.name }}"
    - cwd: /home/vagrant/{{ item.name }}/
    - require:
        - sls: virtualenvs
        - file: /home/vagrant/{{ item.name }}

/home/vagrant/{{ item.name}}/{{ item.name }}/{{ item.name }}/settings.py:
  file.managed:
    - source: salt://django-projects/settings.py
    - template: jinja
    - user: vagrant
    - group: vagrant
    - mode: 644
    - context:
        dbuser: {{ item.dbuser }}
        dbpasswd: {{ item.dbpasswd }}
        dbname: {{ item.dbname }}
        dbengine: {{ item.dbengine }}
        dbhost: {{ item.dbhost }}
        dbport: {{ item.dbport }}
        name: {{ item.name }}

syncdb Django project:
  cmd.run:
    - user: vagrant
    - name: ". .venv/bin/activate && cd django1 && python manage.py syncdb --noinput && python manage.py collectstatic --noinput"
    - cwd: /home/vagrant/{{ item.name }}/
    - order: last
{% endfor %}
