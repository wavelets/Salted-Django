base:
  pkgrepo.managed:
    - humanname: PostgreSQL Apt Repo
    - name: 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main'
    - file: /etc/apt/sources.list.d/pgdg.list
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc

  pkg.latest:
    - name: postgresql-9.3
    - refresh: True
