include:
  - modules.haproxy.init

scp-haproxy-config:
  file.managed:
    - name: /usr/local/haproxy/etc/haproxy.cfg
    - source: salt://haproxy/haproxy-L4.cfg
    - template: jinja
    - default:
      monitor_addr: {{ grains['ip_interfaces']['eth0'][0] }}
      monitor_port: 1080
      admin_user: admin
      admin_pass: admin
      vip_addr: {{ pillar['vip_addr'] }}
      vip_port: 8080
  cmd.run:
    - name: /usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/etc/haproxy.cfg
    - unless: ps -ef |grep haproxy |grep -v grep 
    - requier:
      - file: scp-haproxy-config
