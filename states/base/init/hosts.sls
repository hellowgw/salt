sync-hosts:
  file.managed:
    - name: /etc/hosts
    - source: salt://init/files/hosts
    - user: root
    - group: root
    - mode: 644
