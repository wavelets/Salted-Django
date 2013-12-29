include:
  - packages
  - pip-packages

/etc/uwsgi/apps-enabled:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: true
    - require:
      - sls: packages
      - sls: pip-packages
    
/etc/init/uwsgi.conf:
  file.managed:
    - source: salt://uwsgi/uwsgi.conf
    - template: jinja
    - require:
      - sls: packages
      - sls: pip-packages
        
uwsgi-service:
  service.running:
    - enable: True
    - name: uwsgi
    - require:
      - file: /etc/init/uwsgi.conf

/var/log/uwsgi:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: true
    - require:
      - sls: packages
      - sls: pip-packages
        
/var/log/uwsgi/emperor.log:
  file.managed:
    - user: www-data
    - group: www-data
    - require:
      - sls: packages
      - sls: pip-packages
