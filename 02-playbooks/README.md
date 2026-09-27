# 02 — Playbooks

Playbooks are YAML files describing the *desired state* of your systems, run in order, idempotently.

## Contents
- `hello-world.yml` — the simplest possible playbook
- `install-nginx.yml` — install, configure, and start a web server

## Run
```bash
ansible-playbook -i ../hosts.ini hello-world.yml
ansible-playbook -i ../hosts.ini install-nginx.yml -b
```

## Key Concepts
- A playbook is a list of **plays**.
- Each play targets a **host group** and runs a list of **tasks**.
- Tasks call **modules** (e.g. `apt`, `copy`, `service`) with idempotent behavior — running twice causes no extra changes.
