---
type: model-profile
title: Default executor routing (A/B Jul 2026)
description: Evidence-based model selection after Ornith vs Prisma benchmark
tags: [local-llm, routing, qwen, ornith, ab-benchmark]
timestamp: 2026-07-04T17:48:00Z
---

# Default executor routing

Jul 4 2026 A/B: Ornith-only synthetic + harness smoke vs frozen Prisma baseline.

## Scores

| Metric | Prisma | Ornith |
|--------|--------|--------|
| tool-eval hardmode | **88/100** | 78/100 |
| tok/s c1 median | ~36 | ~108.5 |
| harness smoke (2 AC) | n/a | 2/2 pass |

## Recommendation

**Default executor: `qwen3.6-27b` (PrismaAURA)**

Ornith is ~3× faster but 10 points lower on tool-eval and weaker on safety scenarios (46% on Safety & Boundaries). Decision rule: tool-eval + harness pass rate — speed alone insufficient.

## Role routing

| Role | Model |
|------|-------|
| execute-spec / tool-heavy | **qwen3.6-27b** |
| Latency-sensitive interactive | Ornith acceptable if quality checked |
| Planner | Opus / Cursor |

## Speed without switching

If Prisma feels slow, enable DFlash Tier 1 on DGX before considering Ornith — see spark_ops `QWEN36_27B_PRISMA_RUNBOOK.md`.

## Related

- [Tool-call patterns](tool-call-patterns.md)
- [Qwen3.6-27B guardrails](qwen36-27b-guardrails.md)
- [Ornith 35B guardrails](ornith-35b-guardrails.md)
- spark_ops `docs/MODEL_AB_RUNBOOK.md`
