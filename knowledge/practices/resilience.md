---
type: practice
title: Resilience
description: Retries, exponential backoff, circuit breakers, idempotency for production services
tags: [resilience, retry, circuit-breaker, idempotency]
timestamp: 2026-07-04T16:00:00Z
---

# Resilience

From agent-harness resilience skill.

## Retries

- Retry only **transient** failures (timeouts, 429, 503)
- Exponential backoff with jitter; cap max attempts
- Never retry non-idempotent operations without idempotency key

## Circuit breakers

- Open after N consecutive failures; half-open probe; close on success
- Use for external APIs (Polymarket, Helius, Bedrock) where cascade failure is costly

## Idempotency

- Payment/trade/order endpoints: idempotency key in header or body
- DB upserts vs blind inserts for webhook handlers

## Timeouts

- Every outbound HTTP/RPC call gets connect + read timeout
- Fail fast; don't block worker threads indefinitely

## Related

- [API design](api-design.md)
- [Resilience skill](../../opencode/skills/resilience/SKILL.md)
