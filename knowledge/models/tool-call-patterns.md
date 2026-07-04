---
type: model-profile
title: Tool-call patterns
description: When to use which Hermes tools and common malformed patterns on small local models
tags: [local-llm, tools, hermes, execute-spec]
timestamp: 2026-07-04T17:00:00Z
---

# Tool-call patterns

## Preferred flow (execute-spec)

1. Read `.harness/task-packet.md` — one AC only
2. `knowledge-lookup` if AC touches external APIs
3. Locate → read narrow range → edit → run `check_command`
4. Halt for human approval when green

## Tool selection

| Task | Prefer | Avoid |
|------|--------|-------|
| Find symbol/file | `grep`, `search_files` | Reading whole repo |
| Understand API | OKF concept file | Guessing params |
| Edit code | `patch` with small hunks | Rewriting entire files |
| Verify | packet `check_command` | Extra re-runs after green |
| Context | 2–3 knowledge files max | Loading all skills |

## Common malformed patterns

| Pattern | Symptom | Fix |
|---------|---------|-----|
| Unbalanced JSON | Harness auto-repair, wasted turn | Count `{` `}` before emit |
| Invented tool name | 404 / schema error | Re-list available tools |
| Parallel burst | Partial failures on small models | Serialize calls |
| Huge `read_file` | Context blow-up | Line range or grep first |
| `python -c` one-liner | Sandbox stall ~60s | Scratch script + `uv run` |

## Model-specific parsers (vLLM)

| Model | Parser | Template notes |
|-------|--------|----------------|
| Qwen3.6 Prisma | `qwen3_xml` | `fixed_chat_template-v5.jinja` — explicit `<tool_call>` rules |
| Ornith AEON | `qwen3_coder` | Model default template — do not assume Prisma rules apply |

## Related

- [Small model prompting](small-model-prompting.md)
- [Qwen3.6-27B guardrails](qwen36-27b-guardrails.md)
- [Ornith 35B guardrails](ornith-35b-guardrails.md)
- [tool-call-discipline skill](../../hermes/skills/tool-call-discipline/SKILL.md)
