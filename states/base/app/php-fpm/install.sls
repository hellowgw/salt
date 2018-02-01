scp-php-fpm-config:
  file.managed:
    - name: /usr/local/php/etc/php-fpm.conf
    - source: salt://php/files/php-fpm.conf

scp-php-ini-config:
  file.managed:
    - name: /usr/local/php/etc/php.ini
    - source: salt://php/files/php.ini

start-php-fpm:
  service.running:
    - name: php-fpm
    - enable: True
    - watch:
      - file: scp-php-fpm-config
      - file: scp-php-ini-config
