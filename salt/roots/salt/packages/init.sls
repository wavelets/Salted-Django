mypkgs:
  pkg.installed:
    - pkgs:
{% for package in pillar.get('package', []) %}
        - {{ package.name }}
{% endfor %}
