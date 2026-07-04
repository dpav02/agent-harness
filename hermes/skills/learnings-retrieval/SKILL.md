---
name: learnings-retrieval
description: Retrieve prior harness failure patterns before planning — grep knowledge bundle and project gap logs; spec wins on conflict.
---

# Learnings retrieval (planner)

Cross-run memory is **advisory**. Task packet / spec always wins on conflict.

## When

- **Planner:** before writing task packet (checklist step 0).

## How

1. Read [devshop v1 learnings](~/dev/agent-harness/knowledge/workflows/devshop-v1-learnings.md)
2. If exists: `docs/pipeline-gap-log.md` in target repo
3. Optional: grep `~/.hermes/MEMORY.md` for project-specific notes

Legacy `~/spark/devshop-learnings-search.sh` was removed with devshop v1 — use knowledge bundle instead.

## Use learnings for

- Avoid repeating dependency mistakes
- Tighter acceptance criteria when past runs had scope creep
- Extra test paths when model hit tester-stage limits

## Do not use learnings to

- Override current feature requirements
- Skip live package discovery (planner-spec still required)
- Add scope not in the user's feature request
