---
type: practice
title: Planning spec-driven
description: When to plan, acceptance criteria shape, incremental delivery, assumption validation
tags: [planning, spec, acceptance-criteria]
timestamp: 2026-07-04T16:00:00Z
resource: https://cursor.com/blog/agent-best-practices
---

# Planning spec-driven

Ported from Cursor planning-spec-driven rule and OpenSpec/superpowers patterns.

## When to plan

- **Small/obvious** (typo, one-liner, existing pattern): implement directly
- **Large/ambiguous** (multi-file, unclear requirements, trade-offs): plan first with goal, context, constraints, **done when**

## Plan shape

Good plans name:
- **Goal** — user-visible outcome
- **Context** — files, errors, dependencies that matter
- **Constraints** — stack, auth, deploy targets
- **Done when** — tests, commands, UX checks that prove success

Save substantial plans under `.cursor/plans/` or repo `.harness/task-packet.md`.

## Validate risky assumptions

Before large changes to prompts, parsers, schemas, migrations, external APIs:
- Grep usages, reproduce in test, or hit staging endpoint when safe

## Incremental delivery

Implement in steps with verification between steps. Each step sized for one focused agent session (1–3 files, one logical change).

## Related

- [Spec handoff](../workflows/spec-handoff.md)
- [planner-spec skill](../../hermes/skills/planner-spec/SKILL.md)
- [planning-spec-driven rule](../../cursor/planning-spec-driven.mdc)
