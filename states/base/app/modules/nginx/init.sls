
scp-nginx-files:
  file.recurse:
    - name: /data/src
    - source: salt://app/modules/nginx/files
    - user: root
    - group: root
    - file_mode: 644
  cmd.run:
    - name: mkdir -pv /data/src/soft
    - unless: test -d /data/src/soft

openssl-uncompress:
  cmd.run:
    - name: tar zxf {{ pillar['openssl'] }}.tar.gz -C soft
    - cwd: /data/src
    - unless: test -d /data/src/soft/{{ pillar['openssl'] }}

pcre-uncompress:
  cmd.run:
    - name: tar zxf {{ pillar['pcre'] }}.tar.gz -C soft
    - cwd: /data/src
    - unless: test -d /data/src/soft/{{ pillar['pcre'] }}

ngx_cache_pruge-uncompress:
  cmd.run:
    - name: tar zxf {{ pillar['ngx_cache_purge'] }}.tar.gz -C soft
    - cwd: /data/src
    - unless: test -d /data/src/soft/{{ pillar['ngx_cache_purge'] }}
nginx-uncompress:
  cmd.run:
    - name: tar zxf {{ pillar['nginx'] }}.tar.gz -C soft
    - cwd: /data/src
    - unless: test -d /data/src/soft/{{ pillar['nginx'] }}

nginx-install:
  cmd.run:
    - name: ./configure --prefix=/data/application/{{ pillar['nginx'] }} --user=www --group=www --with-openssl=/data/src/soft/{{ pillar['openssl'] }}/ --with-pcre=/data/src/soft/{{ pillar['pcre'] }}/ --with-http_stub_status_module --with-http_ssl_module --add-module=/data/src/soft/{{ pillar['ngx_cache_purge'] }} && make -j2 && make install && chown -R www.www /data/application/{{ pillar['nginx'] }}
    - cwd: /data/src/soft/{{ pillar['nginx'] }}
    - unless: test -d /data/application/{{ pillar['nginx'] }}
  file.managed:
    - name: /data/application/{{ pillar['nginx'] }}/conf/nginx.conf
    - source: salt://app/modules/nginx/nginx.conf

create-nginx-symlink:
  file.symlink:
    - name: /usr/local/nginx
    - target: /data/application/{{ pillar['nginx'] }}
    - unless: test -d /usr/local/nginx
