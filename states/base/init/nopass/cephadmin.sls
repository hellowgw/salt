sync-sshinfo:
  file.managed:
    - name: /home/cephadmin/.ssh/authorized_keys
    - source: salt://nopass/files/cephadmin_authorized_keys
    - user: cephadmin
    - group: cephadmin
    - mode: 600
