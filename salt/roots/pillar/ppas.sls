ppa:
  - name: redis-server
    ppa: 'chris-lea/redis-server'
    disabled: 'False'
    keyid: 'C7917B12'
    keyserver: 'keyserver.ubuntu.com'
  - name: nginx
    ppa: 'nginx/stable'
    disabled: 'False'
    keyid: 'C300EE8C'
    keyserver: 'keyserver.ubuntu.com'
repo:
  - humanname: PostgreSQL Apt Repo for Ubuntu Precise
    name: 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main'
    file: /etc/apt/sources.list.d/pgdg.list
    key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
