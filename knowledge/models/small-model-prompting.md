---
type: model-profile
title: Small model prompting
description: General mitigations for 27–35B local models in agent harnesses
tags: [local-llm, prompting, context, tools]
timestamp: 2026-07-04T16:00:00Z
---

# Small model prompting

## Context budget

- Prefer progressive disclosure: [OKF index](../index.md) → 2–3 concept files max
- Skills on demand, not all rules always-on
- One acceptance criterion per executor session

## Tool use

- Grep/locate before read entire files
- LSP/symbol search when available (Python strong; Swift weaker)
- **One tool call at a time** when possible — parallel bursts increase malformed JSON on 27–35B models (ornith-guardrails rule 4)
- Load **tool-call-discipline** during execute-spec sessions
- See [tool-call patterns](tool-call-patterns.md) for Hermes tool selection

## Planning vs execution split

| Role | Model | Output |
|------|-------|--------|
| Planner | Opus / Cursor Plan | Task packet with 5–8 ACs |
| Executor | Qwen / Ornith | One AC per session |

Small models fail when asked to plan + implement + verify in one long autonomous chain.

## Verification

- Never claim success without fresh command output this session
- See [verification-before-completion skill](../../hermes/skills/verification-before-completion/SKILL.md)

## Related

- [Supervised agentic loop](../workflows/agentic-loop-supervised.md)
- [Qwen3.6-27B guardrails](qwen36-27b-guardrails.md)
