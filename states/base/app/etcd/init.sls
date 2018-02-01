create-etcd:
  user.present:
    - name: etcd
    - shell: /sbin/nologin
    - uid: 1005
    - gid_from_name: true
    - unless: id -u etcd

/data/application/etcd/bin:
  file.directory:
    - user: etcd
    - group: etcd
    - dir_mode: 755
    - file_mode: 755
    - makedirs: True

/data/application/etcd/conf:
  file.directory:
    - user: etcd
    - group: etcd
    - dir_mode: 755
    - file_mode: 755
    - makedirs: True

/data/application/etcd/data:
  file.directory:
    - user: etcd
    - group: etcd
    - dir_mode: 755
    - file_mode: 755
    - makedirs: True

copy-tar:
  file.managed:
    - name: /data/src/etcd-v3.2.9-linux-amd64.tar.gz
    - source: salt://k8s/etcd/files/etcd-v3.2.9-linux-amd64.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: tar zxf /data/src/etcd-v3.2.9-linux-amd64.tar.gz -C /data/src/soft
    - pwd: /data/src
    - unless: test -d /data/src/soft/etcd-v3.2.9-linux-amd64

etcd:
  cmd.run:
    - name: cp /data/src/soft/etcd-v3.2.9-linux-amd64/etcd /data/application/etcd/bin/
    - unless: test -f /data/application/etcd/bin/etcd
  file.symlink:
    - name: /usr/bin/etcd
    - target: /data/application/etcd/bin/etcd

etcdctl:
  cmd.run:
    - name: cp /data/src/soft/etcd-v3.2.9-linux-amd64/etcdctl /data/application/etcd/bin/
    - unless: test -f /data/application/etcd/bin/etcdctl
  file.symlink:
    - name: /usr/bin/etcdctl
    - target: /data/application/etcd/bin/etcdctl

/data/application/etcd/conf/etcd.conf:
  file.managed:
    - source: salt://k8s/etcd/files/etcd.conf
    - user: etcd
    - group: etcd
    - mode: 644
 
/usr/lib/systemd/system/etcd.service:
  file.managed:
    - source: salt://k8s/etcd/files/etcd.service
    - user: root
    - group: root
    - mode: 644


