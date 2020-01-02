samba:
  pkg.installed

smbd:
  service.running:
    - enable: True
