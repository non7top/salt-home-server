
# Enable auto dhcp for local networks
/etc/systemd/network/20-wired.network:
  file.managed:
    - source: salt://baseconfig/files/20-wired.network
    - watch_in:
      - service: systemd-networkd.service

systemd-networkd.service:
  service.running:
    - enable: True
# End Enable auto dhcp for local networks
