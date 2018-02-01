create-ceph:
  user.present:
    - name: ceph
    - password: $1$12345678$mBvx7PZdJHQBm.b/U0Wd9. 
    - shell: /bin/bash
    - home: /home/ceph
    - uid: 1001
    - gid_from_name: true
    - unless: id -u ceph
