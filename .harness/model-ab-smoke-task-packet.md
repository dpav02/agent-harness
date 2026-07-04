---
type: task-packet
title: Model A/B smoke — OKF lint + tool-call discipline file
repo: agent-harness
check_command: ./scripts/okf-lint.sh
status: pending
current_ac: 1
planner_model: opus
executor_model: ornith
---

# Goal

Smoke test for harness v2 A/B: trivial changes that prove execute-spec + tool-call discipline work on the active executor model.

## Acceptance criteria

1. `./scripts/okf-lint.sh` exits 0 from repo root (no edits required if already green)
2. `knowledge/models/index.md` links to `tool-call-patterns.md`

## Test paths

| AC | Test path |
|----|-----------|
| 1 | `./scripts/okf-lint.sh` |
| 2 | `grep tool-call-patterns knowledge/models/index.md` |

## Dependencies

- `tool-call-discipline` skill installed
- `knowledge/models/tool-call-patterns.md` exists

## Out of scope

- Changing lint rules
- sol-wallet-scanner realistic packet (optional phase 2b)

## Criterion status

| AC | Status | Notes |
|----|--------|-------|
| 1 | pending | |
| 2 | pending | |
