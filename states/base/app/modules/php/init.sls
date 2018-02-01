php-init:
  pkg.installed:
    - pkgs:
      - libxslt-devel
      - libjpeg-turbo
      - libjpeg-turbo-devel
      - libpng
      - libpng-devel
      - freetype
      - freetype-devel
      - libxml2
      - libxml2-devel
      - glib2
      - glib2-devel
      - bzip2
      - bzip2-devel
      - ncurses
      - ncurses-devel
      - e2fsprogs
      - e2fsprogs-devel
      - krb5-devel
      - libidn
      - libidn-devel
      - libmcrypt-devel
      - mhash-devel

scp-libconv-php-files:
  file.managed:
    - name: /data/src/{{ pillar['libconv'] }}.tar.gz
    - source: salt://modules/php/files/{{ pillar['libconv'] }}.tar.gz
  cmd.run:
    - name: tar zxf {{ pillar['libconv'] }}.tar.gz -C soft
    - cwd:  /data/src/
    - unless: test -d /data/src/soft/{ pillar['libconv'] }}
      
libconv-install:
  cmd.run:
    - name: ./configure && make && make install
    - cwd: /data/src/soft/{{ pillar['libconv'] }}
    - requier:
      - cmd: scp-libconv-php-files

/etc/ld.so.conf:
  file.append:
    - text:
      - /usr/local/lib
  cmd.run:
    - name: ldconfig

scp-php-files:
  file.managed:
    - name: /data/src/{{ pillar['php'] }}.tar.gz
    - source: salt://modules/php/files/{{ pillar['php'] }}.tar.gz
  cmd.run:
    - name: tar zxf {{ pillar['php'] }}.tar.gz -C soft
    - cwd: /data/src
    - unless: test -d /data/src/soft/{{ pillar['php'] }}  
    
php-install:
  cmd.run:
    - name: ./configure --prefix=/data/application/{{ pillar['php'] }}  --with-config-file-path=/usr/local/php/etc --with-libdir=lib64 --with-mysql  --with-mysqli --with-iconv --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-xml  --disable-rpath --enable-bcmath  --enable-shmop --enable-sysvsem --enable-inline-optimization  --with-curl --enable-mbregex  --enable-fpm  --enable-mbstring --with-mcrypt  --with-gd --enable-gd-native-ttf --with-mhash --enable-pcntl  --enable-sockets --with-xmlrpc --enable-zip --enable-ftp --with-gettext && make ZEND_EXTRA_LIBS='-liconv' -j2 && make install&& chown -R www.www /data/application/{{ pillar['php'] }}
    - cwd: /data/src/soft/{{ pillar['php'] }}
    - unless: test -d /data/application/{{ pillar['php'] }}
    - requier:
      - cmd: scp-php-files
  file.symlink:
    - name: /usr/local/php
    - target: /data/application/{{ pillar['php'] }}
    - unless: test -d /usr/local/php

add-php-init-script:
  file.managed:
    - name: /usr/lib/systemd/system/php-fpm.service
  cmd.run:
    - name: systemctl daemon-reload
