sync-sshinfo:
  file.managed:
    - name: /home/login/.ssh/authorized_keys
    - source: salt://nopass/files/login_authorized_keys
    - user: login
    - group: login
    - mode: 600
