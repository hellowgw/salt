net.ipv4.ip_nonlocal_bind:
  sysctl.present:
     - value: 1

scp-keepalived-files:
  file.managed:
    - name: /data/src/{{ pillar['keepalived'] }}.tar.gz
    - source: salt://modules/keepalived/files/{{ pillar['keepalived'] }}.tar.gz
  cmd.run:
    - name: tar zxf {{ pillar['keepalived'] }}.tar.gz -C soft
    - cwd: /data/src
    - unless: test -d /data/src/soft/{{ pillar['keepalived'] }}
    - requier:
      - file: scp-keepalived-files

install-keepalived:
  cmd.run:
    - name: ./configure --prefix=/data/application/{{ pillar['keepalived'] }} && make && make install
    - cwd: /data/src/soft/{{ pillar['keepalived'] }}
    - unless: test -d /data/application/{{ pillar['keepalived'] }}
  file.symlink:
    - name: /usr/local/keepalived
    - target: /data/application/{{ pillar['keepalived'] }}
    - unless: test -d /usr/local/keepalived
    - requier:
      - cmd: install-keepalived
