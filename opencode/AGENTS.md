# Global AGENTS.md (OpenCode)

These instructions apply across OpenCode sessions unless a repository-level `AGENTS.md` overrides them.

## Who you are helping

Experienced full-stack founder/developer. Prefer direct, high-signal guidance over tutorials.

## Always-on instruction files

Loaded every session via `opencode.jsonc` — no invocation required:

1. `workflow-agents.md` — ponytail, execution, debugging
2. `testing-agents.md` — TDD, RED-GREEN-REFACTOR, test quality
3. `planning-spec-driven.md` — when to plan, acceptance criteria, incremental delivery

Project-root `AGENTS.md` wins for repo-specific stack details.

## Domain skills (load on demand)

Use the `skill` tool when the task matches:

| Skill | Load when |
|-------|-----------|
| `knowledge-lookup` | Need API docs, practices, or model guardrails from OKF bundle |
| `planner-packet` | Planning a feature for small-model execution (write task packet) |
| `execute-spec` | Executing one AC from `.harness/task-packet.md` (scoped) |
| `backend` | Python APIs, REST, auth, backend services |
| `backend-ts` | TypeScript Lambda, SST, Node API handlers |
| `database` | Schemas, migrations, ORM, SQL, Prisma |
| `aws` | IAM, Lambda, boto3, S3, DynamoDB, Bedrock, IaC |
| `docker` | Dockerfiles, compose, containers |
| `messaging` | Celery, RabbitMQ, SQS, Kafka, queues |
| `observability` | Logging, OTel, Sentry, Datadog |
| `resilience` | Retries, backoff, circuit breakers, idempotency |
| `frontend` | UI, React/Next, Tailwind, a11y, WIG |

Knowledge bundle: `~/dev/agent-harness/knowledge/` (OKF v0.1).

## Verification is mandatory

Before claiming success:

1. Name the claim (tests pass, migration OK, endpoint works).
2. Run the command that proves it.
3. Report exit code and output summary.

Do not guess file contents, test results, or deploy state.

## Spark / DGX defaults

- Live inference and deployed runtimes for `spark_ops`, Gemma, Open WebUI, and related stack run on **DGX Spark** (`edgexpert-84c0` / `edgexpert-84c0.local`) — not the local macOS machine unless the user says otherwise.
- When changing live Spark services: sync repo to DGX checkout and apply the restart/deploy the project expects.
- Model auth env names: `HF_TOKEN`, `CIVITAI_API_KEY` only — no aliases.

## Working style

- Read before write; grep callers before changing shared functions.
- Smallest diff that fixes root cause — no drive-by refactors.
- Ask when auth, migrations, or cross-service deploy are ambiguous.
- Local LLM context budget: prefer 1–3 files per turn; one logical change per turn.

## Cursor equivalents

When using Cursor instead of OpenCode: `~/.cursor/rules/` — see repo `cursor/` directory.

Global dev index: `~/dev/AGENTS.md`
