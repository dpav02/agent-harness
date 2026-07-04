---
type: practice
title: Observability
description: Structured logging, metrics, tracing, Sentry — production visibility
tags: [observability, logging, sentry, otel]
timestamp: 2026-07-04T16:00:00Z
---

# Observability

From agent-harness observability skill; apply on every production path.

## Logging

- Structured JSON or key=value in production services
- Include correlation/request ID across service boundaries
- Log levels: ERROR for action needed, WARN for degraded, INFO for business events, DEBUG off in prod
- Never log secrets, tokens, PII bodies

## Metrics

- RED method: Rate, Errors, Duration for each endpoint/job
- Business metrics where they drive alerts (orders placed, failed trades)

## Tracing

- OpenTelemetry where stack supports it (AWS Lambda, FastAPI middleware)
- Propagate trace context to downstream HTTP calls

## Error reporting

- Sentry (or equivalent) on web + API with release/environment tags
- Capture unhandled exceptions; breadcrumbs for user actions before crash

## Agent discipline

- When adding error paths, add log line + test or assertion that error is surfaced
- Verify observability hooks run in local check command when AC requires it

## Related

- [Resilience](resilience.md)
- [Observability skill](../../opencode/skills/observability/SKILL.md)
