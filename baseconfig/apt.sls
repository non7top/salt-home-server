/etc/apt/apt.conf.d/20auto-upgrades:
  file.managed:
    - source: salt://baseconfig/files/20auto-upgrades
