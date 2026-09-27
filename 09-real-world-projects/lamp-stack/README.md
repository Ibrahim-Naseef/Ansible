# LAMP Stack with Ansible

Provisions Apache, MySQL, and PHP on a fresh Ubuntu host, then deploys a sample PHP page.

```bash
ansible-playbook -i ../../hosts.ini lamp.yml -b
```
