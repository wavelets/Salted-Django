psqlpkgs:
  pkg.installed:
    - pkgs:
      - postgresql-9.3
      - postgresql-9.3-dbg
      - postgresql-server-dev-9.3
    - refresh: True

postgresql:
  service.running:
    - enable: True
    - watch:
        - file: /etc/postgresql/9.3/main/pg_hba.conf
    - require:
        - pkg: psqlpkgs
