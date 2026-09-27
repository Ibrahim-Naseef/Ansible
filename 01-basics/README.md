# 01 — Ansible Basics

Start here. This module covers inventory files and ad-hoc commands — the two things you need before ever writing a playbook.

## Contents
- `inventory/` — sample static inventory files (INI and YAML format)
- `commands/ad-hoc-cheatsheet.md` — the most-used ad-hoc commands with explanations

## Key Concepts
- **Control node**: the machine running Ansible.
- **Managed node**: the target machine(s) being configured.
- **Inventory**: the list of managed nodes (static file or dynamic script/plugin).
- **Ad-hoc command**: a one-off task run directly from the CLI without a playbook.

## Try it
```bash
ansible all -i inventory/hosts.ini -m ping
ansible webservers -i inventory/hosts.ini -a "uptime"
ansible all -i inventory/hosts.ini -m setup | less
```
