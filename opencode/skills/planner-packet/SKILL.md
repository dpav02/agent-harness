---
name: planner-packet
description: Write .harness/task-packet.md for Opus/Cursor planner — goal, 5-8 dependency-ordered ACs, check_command, test paths. Use when planning a feature for small-model execution.
---

# Planner packet (producer)

Use when **planning** a feature for later execution by Qwen/Ornith. Do not implement code in this session.

## Output

Create or update `.harness/task-packet.md` per spec-handoff format in agent-harness `knowledge/workflows/spec-handoff.md`.

## Required frontmatter

`type`, `title`, `repo`, `check_command`, `status: pending`, `current_ac: 0`

## Required sections

Goal, acceptance criteria (5–8), test paths, dependencies, out of scope, criterion status table (`| AC | Status | Red evidence | Notes |`, all `pending`, Red evidence empty).

## Rules

- Each AC one session for executor; dependency-ordered
- Live package discovery; read lockfiles before new deps
- UI: React/Vite — see frontend skill

Load **knowledge-lookup** for domain API references.

Hard/ambiguous packet? See agent-harness `knowledge/models/plan-stage-deliberation.md` — when Fusion/MoA one-shot pays off.
