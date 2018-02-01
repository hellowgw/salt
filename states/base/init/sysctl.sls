net.ipv4.ip_forward:
  sysctl.present:
     - value: 1
net.ipv4.conf.default.rp_filter:
  sysctl.present: 
     - value: 1
net.ipv4.conf.default.accept_source_route:
  sysctl.present: 
     - value: 0
kernel.sysrq:
  sysctl.present: 
     - value: 0
kernel.core_uses_pid:
  sysctl.present: 
     - value: 1
net.ipv4.tcp_syncookies:
  sysctl.present: 
     - value: 1
kernel.msgmnb:
  sysctl.present: 
     - value: 65536
kernel.msgmax:
  sysctl.present: 
     - value: 65536
kernel.shmmax:
  sysctl.present: 
     - value: 68719476736
kernel.shmall:
  sysctl.present:
     - value: 4294967296
net.ipv4.tcp_max_tw_buckets:
  sysctl.present:
     - value: 6000
net.ipv4.tcp_sack:
  sysctl.present:
     - value: 1
net.ipv4.tcp_rmem:
  sysctl.present:
     - value: 4096 87380 4194304
net.ipv4.tcp_wmem:
  sysctl.present:
     - value: 4096 87380 4194304
net.core.wmem_default:
  sysctl.present:
     - value: 8388608
net.core.rmem_default:
  sysctl.present:
     - value: 8388608
net.core.rmem_max:
  sysctl.present:
     - value: 16777216
net.core.wmem_max:
  sysctl.present:
     - value: 16777216
net.core.netdev_max_backlog:
  sysctl.present:
     - value: 262144
net.ipv4.tcp_max_orphans:
  sysctl.present:
     - value: 3276800
net.ipv4.tcp_max_syn_backlog:
  sysctl.present:
     - value: 262144
net.ipv4.tcp_synack_retries:
  sysctl.present:
     - value: 1
net.ipv4.tcp_syn_retries:
  sysctl.present:
     - value: 1
net.ipv4.tcp_tw_recycle:
  sysctl.present:
     - value: 1
net.ipv4.tcp_tw_reuse:
  sysctl.present:
     - value: 1
net.ipv4.tcp_mem:
  sysctl.present:
     - value: 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout:
  sysctl.present:
     - value: 1
net.ipv4.tcp_keepalive_time:
  sysctl.present:
     - value: 30
net.ipv4.ip_local_port_range:
  sysctl.present:
     - value: 1024 65000
net.ipv4.tcp_timestamps:
  sysctl.present:
     - value: 1

init-limits:
  file.managed:
    - name: /etc/security/limits.conf 
    - source: salt://init/files/limits.conf
    - user: root
    - group: root
    - mode: 644
