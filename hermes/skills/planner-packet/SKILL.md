---
name: planner-packet
description: Write .harness/task-packet.md for Opus/Cursor planner — goal, 5-8 dependency-ordered ACs, check_command, test paths. Use when planning a feature for small-model execution.
---

# Planner packet (producer)

Use when **planning** a feature for later execution by Qwen/Ornith/Hermes. Do not implement code in this session.

## Output

Create or update `.harness/task-packet.md` per [spec-handoff format](~/dev/agent-harness/knowledge/workflows/spec-handoff.md).

## Required frontmatter

```yaml
type: task-packet
title: ...
repo: ...
check_command: ...   # per-repo canonical verify command
status: pending
current_ac: 0
```

## Required sections

1. Goal
2. Acceptance criteria (5–8, atomic, dependency-ordered)
3. Test paths (exact command/file per AC)
4. Dependencies table or "None — template deps only"
5. Out of scope
6. Design direction (UI only)
7. Criterion status table (all `pending`, Red evidence column empty):

```md
| AC | Status | Red evidence | Notes |
|----|--------|--------------|-------|
| 1 | pending | | |
```

## Rules

- Each AC completable in one small-model session (1–3 files)
- Live package discovery before proposing deps (read lockfiles first)
- UI features: React/Vite in `web/` — see **frontend-spec**
- Split epics into multiple packets

## Done when

Packet file exists, passes human review, ready for `execute-spec`.

## Knowledge

Load **knowledge-lookup** for API/practice references when planning domain features.

Hard/ambiguous packet? See [plan-stage deliberation](~/dev/agent-harness/knowledge/models/plan-stage-deliberation.md) — when Fusion/MoA one-shot pays off.
