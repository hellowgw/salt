create-login:
  user.present:
    - name: login
    - password: $1$123456$crg1x8fttgTqovkz8LZ9c1
    - shell: /bin/bash
    - home: /home/login
    - uid: 502
    - gid_from_name: true
    - unless: id -u login
