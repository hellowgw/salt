sync-sshinfo:
  file.managed:
    - name: /root/.ssh/authorized_keys
    - source: salt://nopass/files/root_authorized_keys
    - user: root
    - group: root
    - mode: 600
