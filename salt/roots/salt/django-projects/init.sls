include:
    - virtualenvs
{% for item in pillar.get('project', []) %}
/etc/uwsgi/apps-available/{{item.name}}.ini:
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

enable-uwsgi-app-{{item.name}}:
  file.symlink:
    - name: /etc/uwsgi/apps-enabled/{{item.name}}.ini
    - target: /etc/uwsgi/apps-available/{{item.name}}.ini
    - force: false

/home/vagrant/{{item.name}}:
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
    - name: ". .venv/bin/activate && django-admin.py startproject  {{item.name}}"
    - cwd: /home/vagrant/{{item.name}}/
    - require:
        - sls: virtualenvs
        - file: /home/vagrant/{{item.name}}
{% endfor %}
