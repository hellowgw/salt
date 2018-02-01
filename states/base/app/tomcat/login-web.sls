 {% set app_name = 'login-web' %}
 {% set app_shutdown_port = '8101' %}
 {% set app_connector_port = '8201' %}
 {% set app_AJP_connector_port = '8301' %}

/data/application/tomcat:
  file.directory:
    - user: www
    - group: www
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data/application/tomcat

install-tomcat:
  file.managed:
    - name: /data/src/{{ pillar['tomcat_version'] }}.tar.gz
    - source: salt://app/tomcat/files/{{ pillar['tomcat_version'] }}.tar.gz
    - unless: test -f /data/src/{{ pillar['tomcat_version'] }}.tar.gz
    - user: www
    - group: www
    - mode: 644 
  cmd.run:
    - name: tar zxf {{ pillar['tomcat_version'] }}.tar.gz -C /data/application/tomcat && mv /data/application/tomcat/{{ pillar['tomcat_version'] }} /data/application/tomcat/{{ app_name }}
    - cwd: /data/src
    - runas: www
    - unless: test -d /data/application/tomcat/{{ app_name }}
    - requier:
      - file: install-tomcat

scp-catalina:
  file.managed:
    - name: /data/application/tomcat/{{ app_name }}/bin/catalina.sh
    - source: salt://app/tomcat/files/catalina.sh
    - user: www
    - group: www
    - template: jinja
    - default:
      xms_size: 2048
      xmx_size: 2048
      perm_size: 256
      max_perm_size: 256

scp-config:
  file.managed:
    - name: /data/application/tomcat/{{ app_name }}/conf/server.xml
    - source: salt://app/tomcat/files/server.xml
    - user: www
    - group: www
    - template: jinja
    - default:
      shutdown_port: {{ app_shutdown_port }}
      connector_port: {{ app_connector_port }}
      AJP_connector_port: {{ app_AJP_connector_port }}

create-status:
  cmd.run:
    - name: rm -fr /data/application/tomcat/{{ app_name }}/webapps/* && mkdir -p /data/application/tomcat/{{ app_name }}/webapps/status
    - runas: www
    - unless: test -d /data/application/{{ app_name }}/status
    - requier:
      - file: install-tomcat
  file.managed:
    - name: /data/application/tomcat/{{ app_name }}/webapps/status/status.html
    - source: salt://app/tomcat/files/status.html
    - user: www
    - group: www

/data/application/tomcat/{{ app_name }}/backup:
  file.directory:
    - user: www
    - group: www
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /data/application/tomcat/{{ app_name }}/backup

start_tomcat:
  file.symlink:
    - name: /usr/local/tomcat
    - target: /data/application/tomcat
    - unless: test -L /usr/local/tomcat
    - requier:
      - cmd: install-tomcat
  cmd.run:
    - name: sh /usr/local/tomcat/{{ app_name }}/bin/startup.sh
    - runas: www
    - unless: ps -ef |grep '/usr/local/tomcat/{{ app_name }}' |grep -v grep 
    - requier:
      - file: start_tomcat

