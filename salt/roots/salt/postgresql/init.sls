base:
  pkgrepo.managed:
    - humanname: PostgreSQL Apt Repo
    - name: deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main
    - file: /etc/apt/sources.list.d/pgdg.list
    - dist: precise
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc

  pkg.latest:
    - name: postgresql
    - refresh: True
