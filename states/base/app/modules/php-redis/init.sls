scp-php-redis-file:
  file.managed:
    - name: /data/src/{{ pillar['php-redis'] }}.tar.gz
    - source: salt://modules/php-redis/files/{{ pillar['php-redis'] }}.tar.gz
  cmd.run:
    - name: tar zxf {{ pillar['php-redis'] }}.tar.gz -C /data/src/soft
    - cwd: /data/src/
    - unless: /data/src/soft/{{ pillar['php-redis'] }}

install-php-redis:
  cmd.run: 
    - name: /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make -j2 && make install && chown -R www.www /data/application/{{ pillar['php'] }}
    - cwd: /data/src/soft/{{ pillar['php-redis'] }}
    - unless: find /usr/local/php/lib/php/extensions/ -name redis.so | grep redis.so
  file.append:
    - name: /usr/local/php/etc/php.ini
    - text: 
      - extension=redis.so

php-redis-service:
  service.running:
    - name: php-fpm
    - enable: True
    - watch:
      - file: install-php-redis
 
