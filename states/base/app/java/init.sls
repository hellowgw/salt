/usr/java/:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - unless: test -d /usr/java

java-file:
  file.managed:
    - name: /data/src/{{ pillar['java_file'] }}
    - source: salt://app/java/files/{{ pillar['java_file'] }}
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: tar zxf {{ pillar['java_file'] }} -C /usr/java/ && rm -fr /usr/bin/java* && rm -fr /usr/bin/jar
    - cwd: /data/src
    - unless: test -d /usr/java/{{ pillar['java_dir'] }}
    - requier:
      - file: java-file

/etc/profile:
  file.append:
    - text:
      - export JAVA_HOME=/usr/java/{{ pillar['java_dir'] }}
      - export JAVA_BIN=/usr/java/{{ pillar['java_dir'] }}/bin
      - export PATH=$PATH:$JAVA_HOME/bin
      - export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
      - export JAVA_HOME JAVA_BIN PATH CLASSPATH
  cmd.run:
    - name: ln -s /usr/java/{{ pillar['java_dir'] }}/bin/jar /usr/bin/jar && ln -s /usr/java/{{ pillar['java_dir'] }}/bin/java /usr/bin/java && ln -s /usr/java/{{ pillar['java_dir'] }}/bin/javac /usr/bin/javac && ln -s /usr/java/{{ pillar['java_dir'] }}/bin/javadoc /usr/bin/javadoc && ln -s /usr/java/{{ pillar['java_dir'] }}/bin/javaws /usr/bin/javaws && source /etc/profile
