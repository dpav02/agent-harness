---
type: model-profile
title: Qwen3.6-27B guardrails
description: Prompting and harness discipline for dgx/qwen3.6-27b via vLLM PrismaAURA
tags: [qwen, vllm, dgx, local-llm]
timestamp: 2026-07-04T16:00:00Z
---

# Qwen3.6-27B guardrails

Default model in OpenCode (`dgx/qwen3.6-27b`) and Hermes VPS config pointing at DGX Tailscale endpoint.

## Deployment

- vLLM on DGX Spark: `http://edgexpert-84c0:8080/v1` (Mac) or Tailscale IP from VPS
- 262K context; 8K output; 600s request timeout in opencode.jsonc
- Preflight: `spark_ops/bin/spark-opencode-check.sh --chat`

## Harness discipline

- **1–3 files per turn**; one logical change per turn
- Load domain **skills** on demand; don't rely on training memory for API details
- Read [knowledge bundle](../index.md) via knowledge-lookup skill before guessing external APIs

## Failure modes

- Tool hallucination on unfamiliar APIs → link to [API concepts](../apis/index.md)
- Plan drift on multi-step tasks → use [task packet](../workflows/spec-handoff.md) one AC at a time
- Context overflow on long sessions → compaction enabled in opencode.jsonc; prefer grep-before-read

## Related

- [Ornith 35B guardrails](ornith-35b-guardrails.md)
- [workflow-agents.md](../../opencode/workflow-agents.md)
