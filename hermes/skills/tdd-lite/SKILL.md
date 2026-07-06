---
name: tdd-lite
description: Lightweight test-first for execute-spec sessions on local models — red-green, fix forward, one AC at a time.
---

# TDD-lite

Lightweight test-first for small-model executor sessions.

## When

- New behavior during **execute-spec** (skip for trivial config/docs-only fixes).

## Steps

1. Read acceptance criteria in `.harness/task-packet.md` — each criterion maps to a test path.
2. Add or adjust a failing test first; run once to confirm red.
3. Record red evidence in the packet status table: command + `-> N failed`.
4. Write minimal code to green (apply ponytail).
5. Do not delete working code and restart — fix forward.

## On failure

- fix-loop max 3 iterations, then mark AC failed and halt (no auto-retry).

## Related

- [Testing concept](~/dev/agent-harness/knowledge/practices/testing.md)
