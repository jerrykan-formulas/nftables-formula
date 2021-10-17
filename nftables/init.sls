{%- from "nftables/map.jinja" import nftables with context -%}

nftables-package:
  pkg.installed:
    - name: {{ nftables.package }}

nftables-config:
  file.managed:
    - name: {{ nftables.conf_file }}
    - source: salt://nftables/files/nftables.conf.jinja
    - template: jinja
    - require:
      - pkg: nftables-package

# Prevent existing ruleset from being flushed during service reload if config
# is invalid and report the error to the user
nftables-check-rules:
  cmd.run:
    - name: '{{ nftables.nft_cmd }} -c -f {{ nftables.conf_file }}'
    - stateful: True
    - onchanges:
      - file: nftables-config

nftables-services:
  service.running:
    - name: {{ nftables.service }}
    - enable: True
    - reload: True
    - require:
      - pkg: nftables-package
      - cmd: nftables-check-rules
    - watch:
      - file: nftables-config
