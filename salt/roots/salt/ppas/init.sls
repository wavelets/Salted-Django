{% for item in pillar.get('ppa', []) %}
base-{{ item.name }}:
  pkgrepo.managed:
    - ppa: {{ item.ppa }}
    - disabled: {{ item.disabled }}
    - keyid: {{ item.keyid }}
    - keyserver: {{ item.keyserver }}
{% endfor %}

