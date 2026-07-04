---
type: workflow
title: Quality gates
description: Verify-before-done, budget caps, fail-stop — no silent retry
tags: [quality, verification, gates]
timestamp: 2026-07-04T16:00:00Z
---

# Quality gates

## Verify before completion

Any success claim needs **fresh evidence this session**:

1. Name the claim
2. Run `check_command` from task packet (or AC-specific test path)
3. Read exit code and output
4. Report precisely; update packet only on proven green

## Budget caps (per executor session)

| Cap | Value | On exceed |
|-----|-------|-----------|
| Fix iterations | 3 | Mark AC `failed`, halt |
| Max turns | 60 (Hermes config) | Halt, report state |
| Files edited | prefer 1–3 | Split AC if more needed |

## Fail-stop

- **No auto-retry** on failure
- Write failure notes to packet; set AC `failed`; stop session
- User explicitly invokes `resume` (continue with hint) or `retry` (fresh attempt, git reset AC work if needed)

## Scoped activation

Pipeline gates apply only when `.harness/task-packet.md` exists or user invokes execute-spec. Casual chat unaffected.

## Related

- [verification-before-completion skill](../../hermes/skills/verification-before-completion/SKILL.md)
- [fix-loop skill](../../hermes/skills/fix-loop/SKILL.md)
- [Supervised loop](agentic-loop-supervised.md)
