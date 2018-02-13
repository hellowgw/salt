kvm-install:
  pkg.installed:
    - pkgs:
      - libvirt 
      - libvirt-python
      - libvirt-client
      - bridge-utils 
      - virt-manager 
      - virt-viewer 
      - virt-v2v 
      - virt-install
      - device-mapper-devel

kvm-service:
  service.running:
    - name: libvirtd
    - enable: True

/data/application/kvm/vm_pool:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: True

/usr/local/kvm:
  file.symlink:
    - target: /data/application/kvm
