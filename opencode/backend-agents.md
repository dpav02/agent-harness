# Backend agents (OpenCode / Ornith)

Python-first backend, REST API design, auth, ops. Match existing project patterns when present.

## Local-LLM harness discipline (Ornith)

These rules are **front and center** — smaller local models skip steps without explicit prompts.

- **One logical change per turn** — don’t refactor adjacent modules while fixing a bug.
- **Read before write** — open the file; don’t assume signatures from memory.
- **Grep callers** before changing shared functions — fix the shared function once at the root.
- **Smallest diff that fixes root cause** — no drive-by cleanup.
- **Prove it** — `uv run pytest …`, `ruff check …`, or the repo’s documented command; paste exit code + summary.
- **Stop and ask** when auth, migrations, or cross-service deploy are ambiguous.
- **Context budget** — prefer editing 1–3 files per task; for large features, break into explicit steps.
- **Before any list endpoint** — state query count target (e.g. “≤3 queries for GET /orders?page=1”).
- **Before any new route** — state resource name (plural noun), HTTP method, success status, error shape; reject verb-in-URL designs.

## Context: greenfield vs existing

- **Existing codebase:** Extend routes, schemas, services, error envelopes. No new framework unprompted.
- **Greenfield:** Confirm auth, versioning, error format — or default to RFC 9457 + `/api/v1/`.

## Read the repo first

Skim `README`, `AGENTS.md`, `pyproject.toml`, existing handlers before adding endpoints.

## RESTful API design

### Resource naming and URLs

- Resources are **nouns**; HTTP methods are actions.
- Plural collections: `/users`, `/orders`. Kebab-case: `/order-items`.
- Max **2 nesting levels**; flatten deeper hierarchies with query params.
- No CRUD verbs in paths. Version: `/api/v1/...` unless repo uses header versioning.
- Filter/sort via query params: `GET /orders?status=open&sort=-created_at`.

### HTTP methods and status codes

| Method | Use | Success |
|--------|-----|---------|
| GET | Read | 200 |
| POST | Create | 201 + `Location` |
| PUT | Full replace | 200/204 |
| PATCH | Partial update | 200 |
| DELETE | Remove | 204 |

Use **401/403/404/409/422/429** precisely — not 500 for validation or missing resources.

### Errors

- Never 200 with `{ "error": … }`.
- Greenfield: RFC 9457 `application/problem+json` (`type`, `title`, `status`, `detail`, `errors[]`).
- Existing repos: match project envelope — one error shape per API.
- No stack traces in production responses.

### Pagination

- Cursor/keyset for large or changing datasets; cap `limit`.
- Offset only for small admin lists.
- Sort with tie-breaker (`id`).

### Idempotency

- `Idempotency-Key` header on POST that creates/charges/sends; cache ~24h; 409 if same key, different body.
- ETag / `If-Match` or version field for optimistic concurrency → 409 on stale write.

### Security and ops

- Auth per repo; no credentials in query strings.
- 429 + `Retry-After` for rate limits.
- `GET /health` and `GET /ready` for services.
- OpenAPI 3 for HTTP APIs.

### REST anti-patterns

Reject: verbs in URLs, singular collections, deep nesting, unbounded lists, POST without idempotency on orders/payments/notifications.

## Endpoint design: prevent N+1

- List every related field in the response and how it is loaded **before** coding.
- One round-trip per resource type — not N+1.
- Load in repository/query layer, not serializers in a loop.
- Batch: `?ids=` or `/batch` with `WHERE id IN (...)`.
- GraphQL: DataLoader from day one if the repo uses GraphQL.
- Test query count on hot list endpoints when possible.

## Auth and trust boundaries

- Authenticate early; authorize per resource.
- Secrets from env only. Spark repos: `HF_TOKEN`, `CIVITAI_API_KEY` only.
- Redact tokens/PII in logs.

## Concurrency and I/O

- Timeouts; bounded retries with backoff.
- Cleanup in `finally`.

## Testing (pytest)

- Follow **`testing-agents.md`** for TDD and test quality.
- Query-count assertions on list endpoints when applicable.

## Python style

- Type hints on public functions; match project linter (`ruff` in `spark_ops`).

## Ops / spark_ops

- DGX Spark is runtime — not macOS unless stated.
- Sync repo → deploy for live service changes.

## Defer to repo

FastAPI vs Django, httpx vs requests — use what’s already there.
