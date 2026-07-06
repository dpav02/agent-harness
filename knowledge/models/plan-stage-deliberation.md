---
type: model-profile
title: Plan-stage deliberation
description: When to spend on multi-model deliberation (Fusion / MoA) — planning only, never the executor loop
tags: [planning, fusion, moa, openrouter, hermes, cost]
timestamp: 2026-07-06T00:00:00Z
---

# Plan-stage deliberation

When to pay for multi-model deliberation. Short answer: only for writing hard task packets, one-shot.

## Options

| Option | Mechanism | Cost |
|--------|-----------|------|
| OpenRouter Fusion (`openrouter/fusion`) | Panel of models + judge + final answer in one call | ~4–5× single completion |
| Hermes Agent MoA presets | Reference models advise, aggregator acts and makes tool calls | Panel tax multiplies **per TURN** |

## Never in the executor loop

An executor AC runs 16–30 tool calls; MoA pays the panel tax on every turn — for a stage whose gate is pytest anyway. The executor's quality gate is mechanical (red/green + `check_command`), not deliberation.

## Rule of thumb

| Packet | Approach |
|--------|----------|
| Routine | Single frontier model + planner-packet skill |
| Ambiguous architecture / greenfield / conflicting requirements | Fusion or MoA **one-shot**, then normal single-model refinement |

## Related

- [Default executor routing](default-executor-routing.md)
- planner-packet skill (`hermes/skills/planner-packet/SKILL.md`)
