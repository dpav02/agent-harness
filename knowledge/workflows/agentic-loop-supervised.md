---
type: workflow
title: Supervised agentic loop
description: Human gate between ACs, fail-stop, resume/retry commands
tags: [agentic-loop, supervised, hermes, opencode]
timestamp: 2026-07-04T16:00:00Z
---

# Supervised agentic loop (harness v2)

Replaces autonomous devshop v1 kanban pipeline.

```mermaid
flowchart LR
    planner[Opus writes task packet] --> ac1[Executor AC1]
    ac1 --> gate1{Human approve?}
    gate1 -->|yes| ac2[Executor AC2]
    gate1 -->|no / failed| halt[Halt fail-stop]
    halt --> resume[User: resume or retry]
    resume --> ac1
    ac2 --> done[Packet status done]
```

## Loop steps

1. **Plan** — Opus/Cursor loads planner-packet skill, writes `.harness/task-packet.md`
2. **Execute one AC** — small model loads execute-spec; sets AC `in-progress`; implements; runs test path; runs `check_command`
3. **Stop** — on green: mark AC `done`, report summary, **halt** (wait for human)
4. **Human gate** — user replies approve / fix hint / abort
5. **Next AC** — fresh session or `resume` for next pending AC
6. **On failure** — mark `failed`, halt; user chooses `retry` or edits packet

## Commands (user → agent)

| Command | Meaning |
|---------|---------|
| `execute-spec` | Start or continue packet execution |
| `resume` | Continue from packet state after human fix/hint |
| `retry` | Re-attempt failed AC from clean git state |
| (no command) | General chat — pipeline skills inactive |

## What v2 removed

- Kanban board, stage profiles, watchdog auto-requeue
- Global pipeline rules on all Telegram messages
- `~/spark/devshop-check.sh` — replaced by packet `check_command`

## Related

- [Devshop v1 learnings](devshop-v1-learnings.md)
- [Spec handoff](spec-handoff.md)
