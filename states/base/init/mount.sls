create-filesystem:
  cmd.run:
    - name: mkfs.xfs -i size=512 /dev/vdb1 -f

/data:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data
  mount.mounted:
    - device: /dev/vdb1
    - fstype: xfs
    - opts: noatime
    - persist: True
    - mkmnt: True
