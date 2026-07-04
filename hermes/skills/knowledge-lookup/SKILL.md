---
name: knowledge-lookup
description: Navigate the agent-harness OKF knowledge bundle — read index first, follow at most 2-3 concept links. Use when needing API docs, practices, or model guardrails before guessing.
---

# Knowledge lookup

Progressive disclosure over the OKF bundle at `~/dev/agent-harness/knowledge/`.

## Steps

1. Read `~/dev/agent-harness/knowledge/index.md`
2. Open **at most 2–3** linked concept files relevant to the task
3. Do **not** load the entire bundle into context
4. Prefer linked concepts over training memory for API details

## When to use

- Before calling Polymarket, Solana, AWS, Hyperliquid, ComfyUI APIs
- When applying frontend, testing, observability, or resilience patterns
- When executor needs small-model guardrails from `knowledge/models/`

## Related skill

Load **ornith-guardrails** when executing code on local Qwen/Ornith models.
