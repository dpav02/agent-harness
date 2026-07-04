---
name: tool-call-discipline
description: Tool-call reliability rules for local executor models during execute-spec — one call at a time, valid JSON, schema-faithful names. Load with execute-spec sessions.
---

# Tool-call discipline

Scoped like **execute-spec**: load when `.harness/task-packet.md` exists or user runs `execute-spec` / `resume` / `retry`.

## Before every tool call

1. **One tool at a time** when possible — sequential beats parallel bursts on 27–35B models (see ornith-guardrails rule 4).
2. **Names from schema only** — never invent tool names or parameters not in the active tool list.
3. **JSON balance** — validate braces/brackets and quote escaping before emit; multi-line string args are the #1 repair source.
4. **Knowledge first** — for API/domain work, load **knowledge-lookup** and read the relevant concept file before calling HTTP/SDK tools (reduces hallucinated params).

## Hermes tool surface

During execute-spec, prefer:

| Need | Tool |
|------|------|
| Find files | `search_files` / `grep` |
| Read code | `read_file` (narrow range) |
| Edit | `patch` / `write_file` |
| Run checks | `run_command` with packet `check_command` |
| Domain facts | `skill` → `knowledge-lookup` |

Avoid during execute-spec unless AC requires it: `session_search`, broad `web_search`, parallel multi-tool bursts.

## On malformed emit

If the harness repairs your tool call, treat it as a failure signal — re-read the schema, simplify arguments, try again with a smaller payload.

## Related

- [tool-call-patterns](~/dev/agent-harness/knowledge/models/tool-call-patterns.md)
- [small-model-prompting](~/dev/agent-harness/knowledge/models/small-model-prompting.md)
- [ornith-guardrails](../ornith-guardrails/SKILL.md)
