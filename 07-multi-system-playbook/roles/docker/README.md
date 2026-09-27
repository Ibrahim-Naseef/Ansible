# Docker Multi-System Ansible Role

Installs and configures Docker across supported Linux distributions using a
single reusable Ansible role.

## Supported distributions

- Ubuntu / Debian-family systems
- Amazon Linux
- Red Hat Enterprise Linux

The role selects the OS-specific installation task automatically using
`ansible_distribution`.

## Role structure

```text
docker/
├── defaults/
│   └── main.yml
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
├── tasks/
│   ├── install_amazon.yml
│   ├── install_redhat.yml
│   ├── install_ubuntu.yml
│   └── main.yml
├── tests/
│   ├── inventory
│   └── test.yml
└── vars/
    └── main.yml
```

## Role variables

| Variable | Default | Purpose |
|---|---|---|
| `docker_users` | `[]` | Users to add to the `docker` group |
| `docker_service_enabled` | `true` | Enable Docker at boot |

## How it works

1. Detects the managed host distribution.
2. Loads the matching installation task file.
3. Installs Docker using the native package manager.
4. Starts and enables the Docker service.
5. Adds configured users to the `docker` group.
6. Verifies the installed Docker version.

## Example

```yaml
- name: Install Docker
  hosts: servers
  become: true

  roles:
    - role: docker
      docker_users:
        - ubuntu
        - ec2-user
      docker_service_enabled: true
```

## Run the playbook

From the repository root:

```bash
ansible-playbook -i hosts.ini 07-multi-system-playbook/install_docker.yml
```

Your inventory must contain a `servers` group.

## Test the role

```bash
cd 07-multi-system-playbook/roles/docker
ansible-playbook -i tests/inventory tests/test.yml
```

## Dependencies

No external Ansible roles are required.

## License

MIT
