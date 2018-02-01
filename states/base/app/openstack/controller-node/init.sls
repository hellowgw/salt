net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

install-contraller-pkg:
  pkg.installed:
    - pkgs:
      - haproxy 
      - keepalived
      - rabbitmq-server
      - mariadb-server
      - memcached 
      - python-memcached
      - openstack-keystone 
      - httpd 
      - mod_wsgi
      - openstack-glance
      - openstack-nova-api 
      - openstack-nova-conductor 
      - openstack-nova-console 
      - openstack-nova-novncproxy
      - openstack-nova-scheduler
      - openstack-neutron
      - openstack-neutron-ml2
      - openstack-neutron-linuxbridge 
      - ebtables
      - openstack-cinder

scp-keepalived-config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://controller-node/files/keepalived-HA.conf
    - template: jinja
    - default:
      router_id: KeepAlived-HA
      insterface_id: eth0
      vip_addr: {{ pillar['vip_addr'] }}
      {% if grains['ip_interfaces']['eth0'][0] == '172.16.1.10' %}
      state_id: MASTER
      priority_id: 100
      {% elif grains['ip_interfaces']['eth0'][0] == '172.16.1.11' %}
      state_id: BACKUP
      priority_id: 90
      {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: scp-keepalived-config

scp-haproxy-config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://controller-node/files/haproxy-L4.cfg
    - template: jinja
    - default:
      monitor_port: 1080
      admin_user: admin
      admin_pass: admin
      vip_addr: {{ pillar['vip_addr'] }}
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - watch:
      - file: scp-haproxy-config 
