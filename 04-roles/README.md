# 04 — Roles

Roles are the standard, reusable way to organize Ansible content (this is the same layout used on Ansible Galaxy).

## Structure
```
webserver/
├── tasks/main.yml       # the list of tasks (entry point)
├── handlers/main.yml    # handlers, triggered by notify
├── templates/           # .j2 Jinja2 templates
├── vars/main.yml        # role-specific variables (high precedence)
└── defaults/main.yml    # role defaults (low precedence, easily overridden)
```

## Use it in a playbook
```yaml
- hosts: webservers
  become: true
  roles:
    - webserver
```

## Scaffold a new role quickly
```bash
ansible-galaxy init rolename
```
