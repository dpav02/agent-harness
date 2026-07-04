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
| tool-eval hardmode | **88/100** (Tier 0) | **91/100** (Tier 1 DFlash, Jul 4 2026) |
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

## DFlash Tier 1 verified (Jul 4 2026)

Production Prisma runs DFlash Tier 1: **+3 tool-eval points** (88 → 91) and **3.3× tok/s** (11 → ~36) vs Tier 0. DFlash improved both quality and speed — no tradeoff. See spark_ops `QWEN36_27B_PRISMA_RUNBOOK.md`.

## Why AEON Ornith scored 78

The benchmarked Ornith is the **abliterated** AEON Ultimate Uncensored build — refusal removal collapsed its Safety & Boundaries category to 46% (3 critical injection failures). Base `deepreinforce-ai/Ornith-1.0-35B` (safety intact, Terminal-Bench 64.2 vs Qwen3.6-35B's 52.5) with the official `qwen3_xml` parser is an untested separate candidate.

## Related

- [Tool-call patterns](tool-call-patterns.md)
- [Qwen3.6-27B guardrails](qwen36-27b-guardrails.md)
- [Ornith 35B guardrails](ornith-35b-guardrails.md)
- spark_ops `docs/MODEL_AB_RUNBOOK.md`
