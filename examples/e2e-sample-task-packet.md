---
type: task-packet
title: E2E validation — add health check endpoint test
repo: agent-harness
check_command: ./scripts/okf-lint.sh
status: pending
current_ac: 0
planner_model: opus
executor_model: qwen3.6-27b
---

# Goal

Validate harness v2 execute-spec flow with a trivial change: ensure OKF lint script exits 0 (proof packet format works).

## Acceptance criteria

1. `./scripts/okf-lint.sh` runs and exits 0 from repo root
2. `knowledge/index.md` lists all top-level sections (practices, apis, workflows, models)

## Test paths

| AC | Test path |
|----|-----------|
| 1 | `./scripts/okf-lint.sh` |
| 2 | `grep -E 'Practices|APIs|Workflows|Models' knowledge/index.md` |

## Dependencies

None — template deps only.

## Out of scope

- Changing lint rules
- Adding vector RAG

## Criterion status

| AC | Status | Notes |
|----|--------|-------|
| 1 | done | Verified in harness implementation session |
| 2 | done | index.md contains all sections |
