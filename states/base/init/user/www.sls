create-www:
  user.present:
    - name: www
    - password: $1$123456$zfQFA5Q0bW1vgknFNR0rv.
    - shell: /bin/bash
    - home: /home/www
    - uid: 1001
    - gid_from_name: true
    - unless: id -u www
