samba:
  pkg.installed

smbd:
  service.running:
    - enable: True

/etc/samba/smb.conf:
  file.managed:
    - source: salt://samba/smb.conf
    - watch_in:
      - service: smbd
