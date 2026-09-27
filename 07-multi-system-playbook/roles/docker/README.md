# 07 — Multi-System Playbook (Docker across distros)

One playbook, one reusable role, three Linux distributions. This module installs and
configures **Docker** on Ubuntu, Amazon Linux, and Red Hat hosts from a single
`ansible-playbook` run — no per-OS playbooks, no manual branching in the play itself.

## Contents
```text
07-multi-system-playbook/
├── install_docker.yml          # entry-point playbook — targets the "servers" group
└── roles/
    └── docker/                 # reusable, OS-aware Docker role
        ├── README.md           # full role reference (variables, task flow, testing)
        ├── defaults/main.yml   # docker_users, docker_service_enabled
        ├── handlers/main.yml   # Restart Docker
        ├── meta/main.yml       # Galaxy metadata
        ├── tasks/
        │   ├── main.yml            # detects the OS, includes the matching install file
        │   ├── install_ubuntu.yml  # apt install docker.io
        │   ├── install_amazon.yml  # dnf install docker
        │   └── install_redhat.yml  # dnf + Docker CE repo swap (removes podman/buildah first)
        ├── tests/
        │   ├── inventory       # localhost test target
        │   └── test.yml        # standalone role test playbook
        └── vars/main.yml       # distro-specific overrides (none required by default)
```

## How it works

1. `install_docker.yml` targets the `servers` inventory group and applies the `docker` role to every host in it, regardless of distribution.
2. `tasks/main.yml` reads the live fact `ansible_distribution` and includes the matching `install_<distro>.yml` file — this is the only branching point in the whole role.
3. Each `install_*.yml` file uses that distribution's native package manager:
   - **Ubuntu** → `apt` (`docker.io`)
   - **Amazon Linux** → `dnf` (`docker`)
   - **Red Hat** → `dnf`, but first removes conflicting `podman`/`buildah` packages, adds the official Docker CE repo, installs `docker-ce` + Buildx + Compose plugins, and switches the firewall backend to `nftables`
4. Control returns to `tasks/main.yml`, which starts/enables the Docker service, adds `docker_users` to the `docker` group, and prints the installed version for verification.
5. Any task that changes the Docker daemon config notifies the `Restart Docker` handler, which only fires once, at the end of the play.

## Role variables

| Variable | Default | Purpose |
|---|---|---|
| `docker_users` | `[]` | Users to add to the `docker` group (e.g. `ubuntu`, `ec2-user`) |
| `docker_service_enabled` | `true` | Whether Docker starts on boot |

## Run it

Your inventory needs a `servers` group containing the Ubuntu, Amazon Linux, and/or
Red Hat hosts you want Docker on:

```ini
[servers]
web1 ansible_host=192.168.1.11   # Ubuntu
web2 ansible_host=192.168.1.12   # Amazon Linux
web3 ansible_host=192.168.1.13   # RHEL
```

Then, from the repository root:

```bash
ansible-playbook -i hosts.ini 07-multi-system-playbook/install_docker.yml -b
```

Ansible detects each host's distribution automatically — no `--limit` or per-OS
playbook needed.

## Test the role in isolation

```bash
cd 07-multi-system-playbook/roles/docker
ansible-playbook -i tests/inventory tests/test.yml
```

This runs the role against `localhost` so you can validate task logic without
spinning up real multi-distro hosts.

## Why this pattern matters

This is the same "one abstraction, many backends" idea used elsewhere in Ansible
(the `package` module wrapping `apt`/`dnf`/`yum`) — except here it's made explicit
and role-scoped, which keeps the branching contained to `tasks/main.yml` instead of
leaking `when: ansible_os_family == "..."` conditionals through every task. See
[`roles/docker/README.md`](roles/docker/README.md) for the full role reference.

## See also
- [`diagrams/ansible-multi-system-workflow.gif`](../diagrams/ansible-multi-system-workflow.gif) — visual flow of this exact role