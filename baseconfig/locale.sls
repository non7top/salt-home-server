# /etc/sysconfig/i18n in rhel

/etc/default/locale:
  file.managed:
    - source: salt://baseconfig/files/locale
