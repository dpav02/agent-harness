# Docker agents (OpenCode / Ornith)

Dockerfiles, compose, container security. Match existing project patterns.

## Local-LLM guardrails

- **Read existing compose/Dockerfile** in repo before editing.
- After compose changes, run **`docker compose config`** and report whether it parses.
- One service or stage change per turn when possible.

## Multi-stage

- Builder: compile + deps. Runtime: artifacts only.
- Name stages; `COPY --from=builder`.

## Versions and security

- Pin base image versions — no `latest`.
- `USER` non-root after root-only install steps.
- `.dockerignore` excludes `.git`, `node_modules`, `.env`, tests.
- Lockfiles copied before source; `npm ci` / `uv sync --frozen`.

## Compose

- `healthcheck` on long-running services.
- `depends_on` + healthy condition when order matters.
- spark_ops: `spark-net`; port registry from repo.

## GPU

- NVIDIA runtime only when project requires GPU.

## Anti-patterns

- Fat single-stage prod images; root runtime; secrets in ARG; no healthcheck.
