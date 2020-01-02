grub-pc:
  pkg.installed

/etc/default/grub:
  file.managed:
    - source: salt://server/files/grub
    - onchanges_in:
      - cmd: update_grub

update_grub:
  cmd.run:
    - name: update-grub
