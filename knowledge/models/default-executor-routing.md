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

## Ornith base 35B A/B (Jul 4 2026)

Base `deepreinforce-ai/Ornith-1.0-35B-FP8` (safety intact, `qwen3_xml` parser, DFlash) scored **86/100** at **~79 tok/s** — confirming the AEON abliteration caused the 78 (safety recovered 46% → 88%). Still 5 points below Prisma Tier 1's 91; weak on Structured Output (67%) and Hard Mode (77%).

**Template overlay (negative result):** Prisma's template-v5 on ornith-base scored **82/100** — Structured Output dropped to 50%. Chat-template discipline blocks only help models fine-tuned against them. Serve each model with its trained template family; do not patch templates at serve time.

## Updated routing (with noise bounds, Jul 4 evening)

Tool-eval run-to-run noise measured at ~±2 points (Prisma Tier 1 n=2: 91, 93 → **~92 ± 2**). The ~6-point gap to ornith-base exceeds the noise band; rankings are solid. ornith-base speculative tokens raised 6 → 11: now **~93 tok/s** (was 79), output-lossless.

| Role | Model |
|------|-------|
| execute-spec / tool-heavy | **qwen3.6-27b** (~92 ± 2) |
| Latency-critical interactive | `ornith-base` (86, ~93 tok/s — 2.6× faster) |
| Uncensored only | AEON Ornith — never as executor |

## Wallet-scanner harness baseline (Jul 5 2026)

First realistic execute-spec baseline on product code (not agent-harness smoke). Frozen packet: 2 ACs (health `rankable_candidates` + `MIN_MEDIAN_CLOSED_PNL` filter). Pin: sol-wallet-scanner `f67d3a0`, packet sha256 `af6450c6…`.

| Metric | Prisma Tier 1 |
|--------|---------------|
| AC pass rate (n=2 runs × 2 AC) | **4/4** |
| AC1 wall / tokens (range) | 106–259s / 531K–1.23M input |
| AC2 wall / tokens (range) | 234–241s / 802K–1.01M input |
| Full pytest after ACs | 139 passed |

Improvement claims require re-running the **same frozen packet** with the same pins — not tool-eval deltas. Details: spark_ops `runs/2026/07/wallet-scanner-harness-baseline.md`.

## Related

- [Tool-call patterns](tool-call-patterns.md)
- [Qwen3.6-27B guardrails](qwen36-27b-guardrails.md)
- [Ornith 35B guardrails](ornith-35b-guardrails.md)
- spark_ops `docs/MODEL_AB_RUNBOOK.md`
