# Backend TypeScript agents (OpenCode / Ornith)

Lambda, SST, Node API handlers, DynamoDB. Not UI/TSX.

## Local-LLM guardrails

- Read existing handler + service layout before adding endpoints.
- One handler or route change per turn when possible.
- Run repo test command (`npm test`, `vitest`) and report exit code.

## TypeScript

- Strict; no `any`; static imports only.
- kebab-case files; PascalCase types; camelCase functions.

## Lambda / API

- Thin handlers: validate → service → response.
- Match project error envelope (`{ data }` / `{ error, code, details }`).
- Idempotent for queue/event triggers.
- REST rules in `backend-agents.md`.

## DynamoDB

- PascalCase tables when repo uses it.
- Key design from access patterns; no hot partitions.

## SST / AWS

- Profile from repo (`AWS_PROFILE=jobpriced`).
- `sst diff` before deploy.

## Bedrock / prompts

- Pure prompt functions; no model IDs in handlers.
- `additionalProperties: false` on JSON schemas.

## Testing

- Follow **`testing-agents.md`** for TDD and test quality.
- Mock AWS services in unit tests.

## Defer to repo

Stack and framework choices already in the project.
