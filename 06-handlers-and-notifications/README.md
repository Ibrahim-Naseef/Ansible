# 06 — Handlers & Notifications

Handlers are tasks that only run when **notified** by another task that reports `changed`, and they run once, at the end of the play (deduplicated even if notified multiple times).

## Contents
- `handlers-demo.yml`

## Run
```bash
ansible-playbook -i ../hosts.ini handlers-demo.yml -b
```

## Key rules
- Handlers run **after all tasks in the play**, in the order they're defined (not the order notified).
- Use `meta: flush_handlers` to force them to run early if needed.
- A task only triggers its handler if the task itself reports `changed: true`.
