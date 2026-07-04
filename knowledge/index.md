---
okf_version: "0.1"
---

# Agent harness knowledge bundle

Curated concepts for OpenCode and Hermes agent working with small local models (Qwen3.6-27B, Ornith 1.0 35B). Navigate progressively — read this index, then open only what you need.

## Practices

* [Frontend design](practices/frontend-design.md) - Distinctive UI craft, anti-slop, Tailwind v4
* [UI/UX](practices/ui-ux.md) - Hierarchy, cognitive load, accessibility defaults
* [Testing](practices/testing.md) - TDD, behavioral tests, RED-GREEN-REFACTOR
* [Observability](practices/observability.md) - Logging, metrics, tracing, error reporting
* [Resilience](practices/resilience.md) - Retries, backoff, circuit breakers, idempotency
* [Security](practices/security.md) - Trust boundaries, secrets, input validation
* [API design](practices/api-design.md) - REST, versioning, error shapes
* [Planning spec-driven](practices/planning-spec-driven.md) - When to plan, acceptance criteria, incremental delivery

## APIs

* [apis/](apis/index.md) - Polymarket, Solana, Hyperliquid, AWS, ComfyUI reference concepts

## Workflows

* [Spec handoff](workflows/spec-handoff.md) - Task packet format for planner → executor
* [Quality gates](workflows/quality-gates.md) - Verify-before-done, budget caps, fail-stop
* [Supervised agentic loop](workflows/agentic-loop-supervised.md) - Human gates, resume/retry
* [Devshop v1 learnings](workflows/devshop-v1-learnings.md) - Postmortem and v2 constraints

## Models

* [models/](models/index.md) - Small-model guardrails and prompting for Qwen3.6-27B and Ornith 35B
