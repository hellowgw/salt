sync-sshinfo:
  cmd.run:
    - name: ssh-keygen -f ~/.ssh/id_rsa -P ""
    - runas: www
    - unless: test -f ~/.ssh/id_rsa
  file.managed:
    - name: /home/www/.ssh/authorized_keys
    - source: salt://init/nopass/files/www_authorized_keys
    - user: www
    - group: www
    - mode: 600
