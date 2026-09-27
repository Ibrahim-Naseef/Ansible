# 03 — Variables & Facts

Variables let you parameterize playbooks. Facts are variables Ansible auto-discovers about each host.

## Contents
- `vars-demo.yml` — variable scoping example
- `group_vars/webservers.yml` — variables applied to a whole group
- `host_vars/web1.yml` — variables applied to a single host

## Variable Precedence (low → high, simplified)
1. Role defaults
2. Inventory `group_vars`
3. Inventory `host_vars`
4. Play vars
5. Task vars
6. Extra vars (`-e` on CLI) — always wins

## Facts
```bash
ansible web1 -m setup                     # all facts
ansible web1 -m setup -a "filter=ansible_distribution*"
```
