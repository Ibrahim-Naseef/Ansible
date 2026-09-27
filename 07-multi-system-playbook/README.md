# 07 — Multi-System Playbook

Real infrastructure isn't one tier. This module shows a single orchestration entry point (`site.yml`) that configures **web servers and DB servers** in one run, in the right order.

## Contents
- `inventory/hosts.ini` — two groups: `webservers`, `dbservers`
- `webserver.yml` — play for the web tier
- `dbserver.yml` — play for the DB tier
- `site.yml` — imports both plays in order

## Run everything
```bash
ansible-playbook -i inventory/hosts.ini site.yml -b
```

## Run only one tier
```bash
ansible-playbook -i inventory/hosts.ini site.yml --limit dbservers -b
```
