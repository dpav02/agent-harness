# Global AGENTS.md (OpenCode)

These instructions apply across OpenCode sessions unless a repository-level `AGENTS.md` overrides them.

## Who you are helping

Experienced full-stack founder/developer. Prefer direct, high-signal guidance over tutorials.

## Always-on instruction files (loaded every session via opencode.jsonc)

No invocation required — all 11 files load automatically:

| Order | File | Scope |
|-------|------|-------|
| 1 | `workflow-agents.md` | Ponytail, verify-before-done, execution, debugging, CI honesty |
| 2 | `testing-agents.md` | TDD, RED-GREEN-REFACTOR, behavior tests, anti-patterns |
| 3 | `backend-agents.md` | Python APIs, REST, auth, ops |
| 4 | `database-agents.md` | Data modeling, ORM, migrations, Prisma |
| 5 | `aws-agents.md` | AWS, IAM, Lambda, boto3, IaC |
| 6 | `docker-agents.md` | Docker, compose, containers |
| 7 | `messaging-agents.md` | Celery, RabbitMQ, SQS, Kafka |
| 8 | `backend-ts-agents.md` | TypeScript, Lambda, SST, Node API |
| 9 | `observability-agents.md` | Logging, OTel, Sentry, Datadog |
| 10 | `resilience-agents.md` | Retries, backoff, jitter, idempotency |
| 11 | `frontend-agents.md` | UI craft, WIG, React/Next perf, Tailwind v4 |

Read and follow all that apply to the task. Project-root `AGENTS.md` wins for repo-specific stack details.

## Verification is mandatory

Before claiming success:

1. Name the claim (tests pass, migration OK, endpoint works).
2. Run the command that proves it.
3. Report exit code and output summary.

Do not guess file contents, test results, or deploy state.

## Spark / DGX defaults

- Live inference and deployed runtimes for `spark_ops`, Gemma, Open WebUI, and related stack run on **DGX Spark** (`edgexpert-84c0` / `edgexpert-84c0.local`) — not the local macOS machine unless the user says otherwise.
- When changing live Spark services: sync repo to DGX checkout and apply the restart/deploy the project expects.

## Canonical auth env names

Across Spark-related repos, use only:

- `HF_TOKEN`
- `CIVITAI_API_KEY`

Do not introduce alternate aliases.

## Working style

- Read before write; grep callers before changing shared functions.
- Smallest diff that fixes root cause — no drive-by refactors.
- Ask when auth, migrations, or cross-service deploy are ambiguous.

## Cursor equivalents

When using Cursor instead of OpenCode:

- Workflow: `~/.cursor/rules/agent-workflow.mdc`, `ponytail.mdc`
- Testing: `~/.cursor/rules/testing.mdc` (alwaysApply)
- Frontend: `~/.cursor/rules/frontend.mdc` (glob on TSX/CSS)
- Domain rules: `~/.cursor/rules/backend.mdc`, etc.

Global dev index: `~/dev/AGENTS.md`
