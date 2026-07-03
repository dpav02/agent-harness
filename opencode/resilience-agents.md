# Resilience agents (OpenCode / Ornith)

Retries, exponential backoff with full jitter, circuit breakers, idempotency gates.

## Local-LLM guardrails

- Before adding retry logic: state **idempotency strategy + max attempts + jitter** in one sentence.
- Classify which exceptions/status codes are retryable before implementing.
- One retry policy change per turn when possible.
- Run repo tests and report exit code after changes.
- Don't introduce circuit breaker unless user asks or repo already has one.

## Decision matrix

| Situation | Action |
|-----------|--------|
| Transient blip | Backoff + full jitter |
| 429 | `Retry-After` first, then backoff |
| 400/401/403/404 | Fail fast |
| Sustained outage | Circuit breaker |
| Payment/email | Idempotency key, then retry |
| Background | Queue + DLQ (messaging-agents.md) |

## Universal rules

- Idempotency gate for mutating ops.
- Max attempts 3–5 + max total wait time.
- Full jitter: `random(0, min(cap, base * 2^attempt))`.
- Parse `Retry-After` before local backoff.
- Log: attempt, max_attempts, delay_ms, error_code, correlation_id.
- No nested SDK + app retries unless customizing.

## HTTP

- Retry: GET/HEAD; POST only with Idempotency-Key.
- Status: 408, 429, 500–504 + timeouts.
- Python: tenacity `wait_exponential_jitter`; httpx needs explicit policy.
- TypeScript: central `withRetry`; honor `retryable` flag.

## AWS SDK

- Use built-in standard/adaptive retries; don't double-wrap.
- Bedrock: retry throttling, not validation errors.

## Celery

- `retry_backoff=True`, `retry_jitter=True`, `retry_backoff_max=600`, finite `max_retries`.
- Specific `autoretry_for` — never `Exception`.
- DLQ after max attempts.

## Circuit breaker

- Only when capped retries aren't enough and outage is sustained.
- opossum (Node), pybreaker (Python) when repo justifies.

## Anti-patterns

- Infinite retry, retry on 400, no jitter, POST without idempotency, nested retries.
