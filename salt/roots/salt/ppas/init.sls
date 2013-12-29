{% for item in pillar.get('ppa', []) %}
base-{{ item.name }}:
  pkgrepo.managed:
    - ppa: {{ item.ppa }}
    - disabled: {{ item.disabled }}
    - keyid: {{ item.keyid }}
    - keyserver: {{ item.keyserver }}
{% endfor %}

{% for item in pillar.get('repo', []) %}
repo-{{ item.humanname }}:
  pkgrepo.managed:
    - humanname: {{ item.humanname }}
    - name: {{ item.name }}
    - file: {{ item.file }}
    - key_url: {{ item.key_url }}
{% endfor %}
