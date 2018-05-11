create-filesystem:
  cmd.run:
    - name: mkfs.xfs -i size=512 /dev/sdd1 -f && mkfs.xfs -i size=512 /dev/sde1 -f && mkfs.xfs -i size=512 /dev/sdf1 -f && mkfs.xfs -i size=512 /dev/sdg1 -f

/data/ceph/osd3:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data/ceph/osd3
  mount.mounted:
    - device: /dev/sdd1
    - fstype: xfs
    - opts: noatime
    - persist: True
    - mkmnt: True

/data/ceph/osd4:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data/ceph/osd4
  mount.mounted:
    - device: /dev/sde1
    - fstype: xfs
    - opts: noatime
    - persist: True
    - mkmnt: True

/data/ceph/osd5:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data/ceph/osd5
  mount.mounted:
    - device: /dev/sdf1
    - fstype: xfs
    - opts: noatime
    - persist: True
    - mkmnt: True

/data/ceph/osd6:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data/ceph/osd6
  mount.mounted:
    - device: /dev/sdg1
    - fstype: xfs
    - opts: noatime
    - persist: True
    - mkmnt: True
