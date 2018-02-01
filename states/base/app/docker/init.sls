copy-docker:
  cmd.run:
    - name: mkdir -pv /data/src
    - unless: test -d /data/src
  file.managed: 
    - name: /data/src/{{ pillar['docker_version'] }}
    - source: salt://k8s/docker/files/{{ pillar['docker_version'] }}
    - unless: test -f /data/src/{{ pillar['docker_version'] }}
    
install-docker:
  cmd.run:
    - cwd: /data/src
    - name: yum -y install {{ pillar['docker_version'] }}
    - unless: test -d /var/lib/docker

copy-config:
  cmd.run:
    - name: mkdir -pv /etc/docker
    - unless: test -d /etc/docker
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://k8s/docker/files/daemon.json
    - user: root
    - group: root
    - mode: 644

start-docker:
  service.running:
   - name: docker
   - enable: True
   #- watch:
   #  - file: copy-config
