# Ansible Ad-hoc Command Cheat-Sheet

| Purpose | Command |
|---|---|
| Test connectivity | `ansible all -m ping` |
| Run a raw shell command | `ansible all -a "df -h"` |
| Run a module with args | `ansible all -m shell -a "uptime"` |
| Copy a file to hosts | `ansible all -m copy -a "src=file.txt dest=/tmp/file.txt"` |
| Install a package (yum) | `ansible all -m yum -a "name=nginx state=present" -b` |
| Install a package (apt) | `ansible all -m apt -a "name=nginx state=present update_cache=yes" -b` |
| Start/enable a service | `ansible all -m service -a "name=nginx state=started enabled=yes" -b` |
| Create a user | `ansible all -m user -a "name=deploy state=present" -b` |
| Gather facts | `ansible all -m setup` |
| Reboot a host | `ansible all -m reboot -b` |
| Check syntax of a playbook | `ansible-playbook site.yml --syntax-check` |
| Dry run (no changes) | `ansible-playbook site.yml --check` |
| Run only tagged tasks | `ansible-playbook site.yml --tags "install"` |
| Limit to one host/group | `ansible-playbook site.yml --limit webservers` |
| List hosts in inventory | `ansible all --list-hosts` |
| Encrypt secrets | `ansible-vault encrypt secrets.yml` |
| Run playbook w/ vault | `ansible-playbook site.yml --ask-vault-pass` |

`-b` = `--become` (privilege escalation, i.e. sudo).
