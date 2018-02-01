base:
  '*':
    - app.nginx.init
    - app.keepalived.init
    - app.haproxy.init
    - app.java.init
    - app.tomcat.init
