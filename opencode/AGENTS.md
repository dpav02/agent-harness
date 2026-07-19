# Global AGENTS.md (OpenCode)

Applies across OpenCode sessions unless a repo-level `AGENTS.md` overrides. Repo-root `AGENTS.md` wins for stack details.

## Hard constraints

- **One tool call per turn** when possible — parallel bursts raise malformed JSON on 27–35B locals.
- **Verify before claiming.** Name the claim → run the command that proves it → report exit code + output. Never guess file contents, test results, or deploy state.
- **Read before write; grep callers before changing a shared function.** Smallest diff that fixes root cause — no drive-by refactors.
- Context budget: 1–3 files/turn, one logical change/turn.

## Skills (load on demand via `skill` tool)

`knowledge-lookup` (API docs / practices / model guardrails — OKF `~/dev/agent-harness/knowledge/`) · `planner-packet` (write task packet) · `execute-spec` (run one AC, scoped) · `backend` · `backend-ts` · `database` · `aws` · `docker` · `messaging` · `observability` · `resilience` · `frontend`.

## Goal execution

- **Multi-AC feature** → `planner-packet`, then `execute-spec`: one AC per session, human gate between ACs, fail-stop (`knowledge/workflows/agentic-loop-supervised.md`).
- **Single bounded chore** → `/loop-goal --acceptance "…" --check "<verify cmd>" --complete-when-checks-pass`. Always pass a check command; never mark complete without fresh green output. (`/goal` was removed — its auto-continue-until-complete prompt drifts on these locals.)

## Spark / DGX defaults

- Live inference for `spark_ops`, Gemma, Open WebUI runs on **DGX Spark** (`edgexpert-84c0`), not local macOS unless told otherwise. Changing live services: sync repo → DGX checkout, apply the restart the project expects.
- Model auth env: `HF_TOKEN`, `CIVITAI_API_KEY` only — no aliases.

## Cursor

Cursor equivalent rules: `~/.cursor/rules/` (repo `cursor/`). Global dev index: `~/dev/AGENTS.md`.
