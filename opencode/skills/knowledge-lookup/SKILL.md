---
name: knowledge-lookup
description: Navigate the agent-harness OKF knowledge bundle — read index first, follow at most 2-3 concept links. Use when needing API docs, practices, or model guardrails before guessing.
---

# Knowledge lookup

Progressive disclosure over the OKF bundle at `~/dev/agent-harness/knowledge/` (or repo-relative `knowledge/` when in agent-harness).

## Steps

1. Read `knowledge/index.md` (or absolute path on VPS: `~/dev/agent-harness/knowledge/index.md`)
2. Open **at most 2–3** linked concept files relevant to the task
3. Do **not** load the entire bundle into context
4. Prefer linked concepts over training memory for API details

## When to use

- Before calling Polymarket, Solana, AWS, Hyperliquid, ComfyUI APIs
- When applying frontend, testing, observability, or resilience patterns
- When executor needs [small-model guardrails](knowledge/models/ornith-35b-guardrails.md)

## Bundle layout

| Path | Contents |
|------|----------|
| `knowledge/practices/` | Frontend, testing, security, planning |
| `knowledge/apis/` | Domain API gotchas |
| `knowledge/workflows/` | Task packets, quality gates |
| `knowledge/models/` | Qwen/Ornith guardrails |

## Lint

Maintainers: `./scripts/okf-lint.sh` from agent-harness root.
