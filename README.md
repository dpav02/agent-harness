# agent-harness

Always-on agent rules for **OpenCode / Ornith** and **Cursor** — workflow, TDD, domain expertise, and frontend craft. No skill invocation; rules load automatically every session.

## Where rules live (installed)

| Tool | Install path | Mechanism |
|------|--------------|-----------|
| **OpenCode** | `~/.config/opencode/` | Files listed in `opencode.jsonc` → `instructions` load every session |
| **Cursor** | `~/.cursor/rules/` | `alwaysApply: true` + glob-attached `.mdc` files |

This repo is the **source of truth**. Install by copying or symlinking from here.

## Layout

```
opencode/
  opencode.jsonc          # instruction file list + provider config
  AGENTS.md               # OpenCode index
  workflow-agents.md      # ponytail, verify-before-done, execution
  testing-agents.md       # TDD, RED-GREEN-REFACTOR, anti-patterns
  backend-agents.md       # Python / REST / ops
  database-agents.md      # ORM, migrations, Prisma
  aws-agents.md           # AWS, IAM, Lambda, IaC
  docker-agents.md        # containers, compose
  messaging-agents.md     # Celery, RabbitMQ, SQS, Kafka
  backend-ts-agents.md    # TypeScript / Lambda / SST
  observability-agents.md # logging, OTel, Sentry
  resilience-agents.md    # retries, backoff, idempotency
  frontend-agents.md      # UI craft, WIG, React perf, Tailwind v4

cursor/
  agent-workflow.mdc      # alwaysApply — execution, verify-before-done
  ponytail.mdc            # alwaysApply — lazy senior dev ladder
  code-quality.mdc        # alwaysApply — intentional code, TS discipline
  testing.mdc             # alwaysApply — TDD and test quality
  planning-spec-driven.mdc
  backend.mdc             # glob: Python, Docker, pyproject
  backend-ts.mdc          # glob: TS server / SST
  database.mdc
  aws.mdc
  docker.mdc
  messaging.mdc
  observability.mdc
  resilience.mdc
  frontend.mdc            # glob: TSX, JSX, CSS, Vue
```

## Install

```bash
# From a clone of this repo:
./install.sh

# Or manually:
cp -r opencode/* ~/.config/opencode/
cp cursor/*.mdc ~/.cursor/rules/
```

Symlink instead of copy (stays in sync with git pull):

```bash
ln -sf "$(pwd)/opencode/"* ~/.config/opencode/
ln -sf "$(pwd)/cursor/"*.mdc ~/.cursor/rules/
```

**Note:** `opencode.jsonc` includes a provider block for Ornith on DGX Spark (`edgexpert-84c0`). Edit or remove that section if you use a different provider.

## OpenCode load order

1. workflow-agents.md
2. testing-agents.md
3. backend → database → aws → docker → messaging → backend-ts → observability → resilience
4. frontend-agents.md

Verify: `opencode debug config`

## Cursor always-on vs globs

**Always apply:** `agent-workflow`, `ponytail`, `code-quality`, `testing`

**Glob-attached:** domain rules attach when you edit matching files (see frontmatter `globs` in each `.mdc`).

## Related

- Global dev index: `~/dev/AGENTS.md` (pointers to these paths; not duplicated here)
