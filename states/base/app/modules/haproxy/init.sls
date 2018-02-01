scp-haproxy-files:
  file.managed:
    - name: /data/src/{{ pillar['haproxy'] }}.tar.gz
    - source: salt://modules/haproxy/files/{{ pillar['haproxy'] }}.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: tar zxf {{ pillar['haproxy'] }}.tar.gz -C soft
    - cwd: /data/src/

install-haproxy:
  cmd.run:
    - name: make TARGET=linux2628 PREFIX=/data/application/{{ pillar['haproxy'] }} && make install PREFIX=/data/application/{{ pillar['haproxy'] }} && chown -R www.www /data/application/{{ pillar['haproxy'] }}
    - cwd: /data/src/soft/{{ pillar['haproxy'] }}
    - unless: test -d /data/application/{{ pillar['haproxy'] }} 
    - requier:
      - cmd: scp-haproxy-files 
  file.symlink:
    - name: /usr/local/haproxy
    - target: /data/application/{{ pillar['haproxy'] }}
    - unless: test -d /usr/local/haproxy
    - requier:
      - cmd: install-haproxy

after-install-haproxy:
  cmd.run:
    - name: cp -fr errorfiles/ /usr/local/haproxy/ && mkdir -p /usr/local/haproxy/{etc,log}
    - cwd: /data/src/soft/{{ pillar['haproxy'] }}/examples
    - unless: test -d /usr/local/haproxy/etc && test -d /usr/local/haproxy/log && test -d /usr/local/haproxy/errorfiles
  file.symlink:
    - name: /var/log/haproxy.log
    - target: /usr/local/haproxy/log/haproxy
    - requier:
      - cmd: after-install-haproxy

config-rsyslog-service:
  cmd.run:
    - name: sed -i 's#SYSLOGD_OPTIONS=\"\"#SYSLOGD_OPTIONS=\"-r -m 0 -c 2\"#g' /etc/sysconfig/rsyslog
  file.managed:
    - name: /etc/rsyslog.conf
    - source: salt://modules/haproxy/rsyslog.conf
  service.running:
    - name: rsyslog
    - enable: True
    - watch:
      - file: config-rsyslog-service
