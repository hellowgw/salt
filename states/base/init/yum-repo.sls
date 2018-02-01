base-repo:
  cmd.run:
    {% if grains['osmajorrelease']=='7' %}
    - name: wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    {% elif grains['osmajorrelease']=='6' %}
    - name: wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
    {% endif %}

epel-repo:
  cmd.run:
    {% if grains['osmajorrelease']=='7' %}
    - name: wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
    {% elif grains['osmajorrelease']=='6' %}
    - name: wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
    {% endif %}

yum-makecache:
  cmd.run:
    - name: yum clean all && yum makecache
