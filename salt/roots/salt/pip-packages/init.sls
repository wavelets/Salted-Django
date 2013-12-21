include:
    - packages

{% for pkg in pillar.get('pip-package', []) %}
{{ pkg.name }}:
    pip.installed:
      - require:
        - sls: packages
{% endfor %}
