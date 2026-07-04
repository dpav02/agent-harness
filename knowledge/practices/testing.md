---
type: practice
title: Testing
description: TDD, RED-GREEN-REFACTOR, behavioral tests, anti-patterns for agent-written code
tags: [testing, tdd, pytest, vitest]
timestamp: 2026-07-04T16:00:00Z
---

# Testing

Aligns with agent-harness testing-agents.md and obra/superpowers TDD methodology.

## RED-GREEN-REFACTOR

1. **RED** — failing test for missing/wrong behavior (not import errors)
2. **GREEN** — minimal code to pass
3. **REFACTOR** — only while green

Bug fix: regression test reproduces bug before fix.

## What makes a good test

- Observable behavior at public surface (API response, UI text/role, DB state)
- Name reads like spec: `rejects_checkout_when_inventory_zero`
- One behavior per test; AAA structure
- Explicit assertions with expected values

## Anti-patterns (reject)

- `assert True`, tautologies, testing mocks exist
- Private method / call order assertions
- Snapshot as only assertion without understanding
- `sleep()` for timing
- Happy path only on critical paths

## Mocking

- Mock external boundaries only (HTTP, DB, queue, clock)
- Patch at use site; prefer fakes over deep mock trees

## Local LLM discipline

- One high-signal test beats five trivial tests
- Run targeted test first; full suite at criterion completion
- See [tdd-lite skill](../../hermes/skills/tdd-lite/SKILL.md)

## Related

- [Quality gates](../workflows/quality-gates.md)
- [Testing agents](../../opencode/testing-agents.md)
