---
type: practice
title: API design
description: REST conventions, error shapes, versioning, pagination
tags: [api, rest, backend, openapi]
timestamp: 2026-07-04T16:00:00Z
---

# API design

From agent-harness backend skills.

## REST conventions

- Nouns for resources; HTTP verbs for actions
- Consistent plural paths: `/wallets`, `/orders/{id}`
- 201 + Location on create; 204 on delete; 409 on conflict

## Error responses

```json
{
  "error": "human_readable_code",
  "message": "What went wrong",
  "details": {}
}
```

- 4xx client errors vs 5xx server errors — don't mask bugs as 400

## Versioning

- URL prefix (`/v1/`) or Accept header — pick one per repo and stick to it

## Pagination

- Cursor-based for large/streaming datasets; offset only for small admin UIs

## SSE/streaming

- Jobpriced pattern: API Gateway SSE for long LLM responses; heartbeat comments

## Related

- [Backend skill](../../opencode/skills/backend/SKILL.md)
- [Observability](observability.md)
