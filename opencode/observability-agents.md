# Observability agents (OpenCode / Ornith)

Structured logging, OpenTelemetry, Sentry, Datadog, log-trace correlation.

## Local-LLM guardrails

- Before adding Sentry/OTel/Datadog: **grep** repo for existing init — extend, don't duplicate stacks.
- State **log format + correlation fields** in one sentence before editing logging code.
- Never log secrets; scrub PII in `beforeSend` when using Sentry.
- One observability init change per turn when possible.
- Prove handler still returns expected envelope after changes; run repo tests.

## Defer to repo

Use Sentry-only, Datadog, OTel, or stdout JSON — whatever the project already chose.

## Structured logging

- JSON in production; one event per line.
- Required: `timestamp`, `level`, `message`/`event`, `service`, `env`, `version`.
- Correlation: `trace_id`, `span_id`, `request_id`/`correlation_id` at top level.
- Severity: `error` = attention; `warn` = expected failure; `info` = business events.
- Never log passwords, tokens, raw Authorization headers.

## OpenTelemetry

- W3C `tracecontext` propagator.
- Auto-instrument HTTP/DB/queue; manual spans for named business ops only.
- Inject trace IDs into logs via SDK bridge or structlog processor.
- Propagate trace context through queues (headers/payload).
- Tail sampling for errors; drop health-check spans.
- No unbounded span attributes.

## Sentry

- Init once; `environment`, `release`, `tracesSampleRate`.
- `beforeSend` scrubs PII; drop expected 4xx.
- Capture 5xx + unhandled; tag `code`, `path`, `method`.
- Fingerprint stable infra error groups.

## Datadog

- `DD_ENV`, `DD_SERVICE`, `DD_VERSION` (Unified Service Tagging).
- `DD_LOGS_INJECTION=true` for trace ↔ log links.
- JSON logs required for correlation.

## Alerts

- Error rate, p99, DLQ depth, retry rate — not just 500 count.
- `/health` vs `/ready` — don't trace as business traffic.

## Anti-patterns

- Printf in prod, full body logging, duplicate capture, high-cardinality metric labels.
