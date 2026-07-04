---
name: tool-call-discipline
description: Tool-call reliability for local executor models — one call at a time, valid JSON, schema-faithful names. Use during execute-spec or implementation sessions.
---

# Tool-call discipline

## Rules

1. **One tool at a time** when possible on 27–35B local models.
2. **Schema-faithful** — only tool names and parameters from the active tool list.
3. **Valid JSON** — balance braces/brackets; escape quotes in string values before emit.
4. **Knowledge first** — run **knowledge-lookup** before API/SDK tools to avoid hallucinated parameters.

## Related

- `knowledge/models/tool-call-patterns.md`
- `knowledge/models/small-model-prompting.md`
