salt-minion:
  service.dead:
    - enable: False
{% set snap_packages = salt['cmd.shell']('snap list --all 2> /dev/null | grep -v Tracking|awk \'{print $1}\'').split('\n') %}

{% for snap in snap_packages %}
{% if snap|length %}
disable_snap_{{ snap }}:
  cmd.run:
    - name: snap disable {{ snap }}
    - onfail:
      - test: snap_core_fail

snap_{{ snap }}:
#  snap.removed:
  cmd.run:
    - name: snap remove {{ snap }}
    - require:
      - cmd: disable_snap_{{ snap }}
    - onfail:
      - test: snap_core_fail
{% endif %}
{% endfor %}

snap_core_fail:
  test.nop:
    - name: Expected to fail on core snap

snapd:
  pkg.purged

/var/lib/snapd:
  file.absent:
    - require:
      - pkg: snapd

/var/cache/snapd/:
  file.absent:
    - require:
      - pkg: snapd
# Ensure default target is set to 'multi-user.target' (non-graphical). Change to 'graphical.target' if that is what you prefer
systemd_default_target:
  cmd.run:
    - name: systemctl set-default multi-user.target
    - unless: test `systemctl get-default` = 'multi-user.target'

switch_to_target:
  cmd.run:
    - name: systemctl isolate multi-user.target
    - unless: test `systemctl list-units --type target | egrep "^eme|^res|^gra|^mul" | head -1|awk '{print $1}'` = 'multi-user.target'


apt_autoremove:
  cmd.run:
    - name: apt autoremove --purge -y

purge_desktop:
  pkg.purged:
    - name: ubuntu-desktop
#    - onchanges_in:
#      - cmd: apt_autoremove

Europe/Moscow:
  timezone.system
