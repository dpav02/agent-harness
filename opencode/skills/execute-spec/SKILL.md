---
name: execute-spec
description: Execute one acceptance criterion from .harness/task-packet.md — TDD, check_command, fail-stop, halt for approval. Use ONLY when task packet exists or user says execute-spec/resume/retry.
---

# Execute spec (consumer)

**Scoped activation:** only when `.harness/task-packet.md` exists OR user says `execute-spec`, `resume`, or `retry`.

## Per AC session

1. Read packet; pick next `pending` AC (or `failed` on `retry`)
2. Load **tool-call-discipline** and **ornith-guardrails** for local model discipline
3. tdd-lite → implement → run test path → run `check_command`
4. Green: AC → `done`, report, **halt**
5. Red after 3 fixes: AC → `failed`, **halt** — no auto-retry

## Fail-stop

User invokes `resume` or `retry` explicitly. See agent-harness `knowledge/workflows/quality-gates.md`.
