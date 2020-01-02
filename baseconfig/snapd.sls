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
