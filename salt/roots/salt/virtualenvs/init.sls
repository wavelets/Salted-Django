{% for venv in pillar.get('virtualenvs', []) %}
{{ venv.dir }}:
   virtualenv.managed:
     - system_site_packages: False
     - requirements: {{ venv.requirements }}
{% endfor %}
