scp-minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://app/salt-minion/files/minion
    - template: jinja
    - default:
      master_ip: 172.16.1.254
      minion_id: {{ grains['localhost'] }}

start-minion:
  service.running:
   - name: salt-minion
   - enable: True
   - watch:
     - file: scp-minion-config
