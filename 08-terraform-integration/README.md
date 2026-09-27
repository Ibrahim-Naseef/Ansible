# 08 — Terraform + Ansible Integration

**Terraform provisions infrastructure** (VMs, networks, security groups). **Ansible configures it** (packages, users, app deployment). This module shows the handoff between the two.

## Contents
- `main.tf` — provisions an EC2 instance and writes a dynamic Ansible inventory
- `configure.yml` — the playbook Terraform triggers after provisioning

## Flow
1. `terraform apply` creates the instance(s) and outputs their IPs.
2. A `local-exec` provisioner (or a separate CI step) generates `inventory.ini`.
3. `ansible-playbook -i inventory.ini configure.yml` configures the new instance(s).

## Run
```bash
terraform init && terraform apply -auto-approve
ansible-playbook -i inventory.ini configure.yml
```
