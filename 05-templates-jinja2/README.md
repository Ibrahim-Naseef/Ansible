# 05 — Jinja2 Templates

Templates (`.j2` files) let you generate config files dynamically using variables, loops, and conditionals.

## Contents
- `nginx.conf.j2` — a real nginx config template
- `template-demo.yml` — playbook that renders it

## Jinja2 essentials
```jinja
{{ variable }}                     {# substitution #}
{% if condition %} ... {% endif %} {# conditional #}
{% for item in list %} ... {% endfor %}  {# loop #}
{{ variable | default('fallback') }}     {# filter #}
```

## Run
```bash
ansible-playbook -i ../hosts.ini template-demo.yml -b
```
