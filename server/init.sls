include:
  - server.grub
#
# Ensure default target is set to 'multi-user.target' (non-graphical). Change to 'graphical.target' if that is what you prefer
systemd_default_target:
  cmd.run:
    - name: systemctl set-default multi-user.target
    - unless: test `systemctl get-default` = 'multi-user.target'

switch_to_target:
  cmd.run:
    - name: systemctl isolate multi-user.target
    - unless: test `systemctl list-units --type target | egrep "^eme|^res|^gra|^mul" | head -1|awk '{print $1}'` = 'multi-user.target'

purge_desktop:
  pkg.purged:
    - name: ubuntu-desktop
#    - onchanges_in:
#      - cmd: apt_autoremove

gnome-shell:
  pkg.purged

nautilus:
  pkg.purged:
    - name: nautilus

gnome-cruft:
  pkg.purged:
    - name: gnome-shell


openssh-server:
  pkg.installed

r8168-dkms:
  pkg.installed


#apt_autoremove:
#  cmd.run:
#    - name: apt autoremove --purge -y
