include:
  - modules.keepalived.init

scp-keepalived-HA-config:
  file.managed:
    - name: /usr/local/keepalived/etc/keepalived/keepalived.conf
    - source: salt://keepalived-HA/keepalived-HA.conf
    - template: jinja
    - default:
      router_id: KeepAlived-HA
      insterface_id: eth0
      vip_addr: {{ pillar['vip_addr'] }}
      {% if grains['ip_interfaces']['eth0'][0] == '172.20.60.71' %}
      state_id: MASTER
      priority_id: 100
      {% elif grains['ip_interfaces']['eth0'][0] == '172.20.60.72' %}
      state_id: BACKUP
      priority_id: 90
      {% endif %}
  cmd.run:
    - name: /usr/local/keepalived/sbin/keepalived -f /usr/local/keepalived/etc/keepalived/keepalived.conf
    - unless: ps -ef |grep '/usr/local/keepalived' |grep -v grep
    - requier:
       - cmd: install-keepalived
      

add-keepalived-HA-bootstart:
  file.append:
    - name: /etc/rc.local
    - text: /usr/local/keepalived/sbin/keepalived -f /usr/local/keepalived/etc/keepalived/keepalived.conf    - requier:
      - file: install-keepalived
