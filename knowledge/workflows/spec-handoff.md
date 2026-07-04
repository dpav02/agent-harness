---
type: workflow
title: Spec handoff task packet
description: YAML-frontmatter task packet format for Opus planner → small-model executor
tags: [spec, task-packet, planner, executor]
timestamp: 2026-07-04T16:00:00Z
---

# Spec handoff — task packet format

File location: `.harness/task-packet.md` in target repo (or path declared in prompt).

## Frontmatter (required)

```yaml
---
type: task-packet
title: Short feature name
repo: sol-wallet-scanner
check_command: uv run pytest -q
planner_model: opus
executor_model: qwen3.6-27b
status: pending  # pending | in-progress | done | failed
current_ac: 0
---
```

## Body sections

1. **Goal** — one paragraph, user-visible outcome
2. **Acceptance criteria** — numbered 1..N, atomic, dependency-ordered (AC *n* depends only on 1..n-1)
3. **Test paths** — exact command or file per AC
4. **Dependencies** — table if new packages; or "None — template deps only"
5. **Out of scope** — explicit exclusions
6. **Design direction** — UI projects only (see [frontend-spec skill](../../hermes/skills/frontend-spec/SKILL.md))
7. **Criterion status** — table updated by executor:

| AC | Status | Notes |
|----|--------|-------|
| 1 | pending | |
| 2 | pending | |

Status values: `pending` | `in-progress` | `done` | `failed`

## Sizing rules

- **5–8 ACs** standard tier; each AC one testable behavior
- Each AC completable in one executor session (1–3 files)
- Split epics into multiple packets, not one mega-packet

## check_command

Per-repo canonical verify command replacing deleted `devshop-check.sh`:

| Repo | Example |
|------|---------|
| sol-wallet-scanner | `uv run pytest -q` |
| jobpriced | `npm test --workspace=@jobpriced/api` |
| polymarket-trader | `uv run pytest -q` |

Planner must set `check_command` in frontmatter.

## Producer / consumer skills

- **Producer:** [planner-packet](../../hermes/skills/planner-packet/SKILL.md) (Opus/Cursor)
- **Consumer:** [execute-spec](../../hermes/skills/execute-spec/SKILL.md) (Qwen/Ornith/Hermes)

## Related

- [planner-spec skill](../../hermes/skills/planner-spec/SKILL.md) — v1 spec format (adapted)
- [Planning spec-driven](../practices/planning-spec-driven.md)
