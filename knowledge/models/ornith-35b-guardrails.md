---
type: model-profile
title: Ornith 35B guardrails
description: Evidence-mined failure patterns from devshop v1 Hermes sessions on local models
tags: [ornith, hermes, local-llm, guardrails]
timestamp: 2026-07-04T16:00:00Z
---

# Ornith 35B guardrails

Content harvested from [ornith-guardrails skill](../../hermes/skills/ornith-guardrails/SKILL.md) — each rule maps to observed pipeline failures.

## 1. Complete immediately once checks are green

After `check_command` exits 0 and `git status --porcelain` is empty: mark criterion done and **halt**. Do not re-read files, re-run tests, or explore further.

## 2. Never use inline interpreter one-liners

No `python -c`, `node -e`, etc. — sandbox approval stalls ~60s then denies (100+ wasted turns in v1).

**Instead:** scratch script via write_file, or add assertion to real test file.

## 3. stderr warnings ≠ failure

`uv run` may print harmless warnings to stderr. Trust **exit code** and explicit pass lines.

## 4. Valid tool-call JSON

Malformed JSON args waste round trips. Balance braces/quotes before emitting multi-line tool args.

## 5. Don't grep passing checks for phantom strings

Empty grep on clean output is not failure. Run checks plain; read pass signal directly.

## v2 additions

- No `kanban_complete` — update task packet status and halt
- No auto-retry on failure — user invokes `resume` or `retry`

## Related

- [Devshop v1 learnings](../workflows/devshop-v1-learnings.md)
- [Quality gates](../workflows/quality-gates.md)
