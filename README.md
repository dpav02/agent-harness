# agent-harness

Always-on agent rules for **OpenCode / Ornith** and **Cursor** — workflow, TDD, domain expertise, and frontend craft. Domain rules load on demand via OpenCode skills.

## Where rules live (installed)

| Tool | Install path | Mechanism |
|------|--------------|-----------|
| **OpenCode** | `~/.config/opencode/` | Always-on: `opencode.jsonc` → `instructions` + auto-loaded `AGENTS.md`. Domain: `skills/*/SKILL.md` via `skill` tool |
| **Cursor** | `~/.cursor/rules/` | `alwaysApply: true` + glob-attached `.mdc` files |

This repo is the **source of truth**. Install by copying or symlinking from here.

## Layout

```
opencode/
  opencode.jsonc          # models, providers, compaction, instruction file list
  AGENTS.md               # OpenCode index + skill trigger map
  workflow-agents.md      # ponytail, verify-before-done, execution (always-on)
  testing-agents.md       # TDD, RED-GREEN-REFACTOR (always-on)
  skills/
    backend/SKILL.md
    backend-ts/SKILL.md
    database/SKILL.md
    aws/SKILL.md
    docker/SKILL.md
    messaging/SKILL.md
    observability/SKILL.md
    resilience/SKILL.md
    frontend/SKILL.md

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
cp opencode/AGENTS.md opencode/workflow-agents.md opencode/testing-agents.md opencode/opencode.jsonc ~/.config/opencode/
cp -r opencode/skills/* ~/.config/opencode/skills/
cp cursor/*.mdc ~/.cursor/rules/
```

Symlink instead of copy (stays in sync with git pull):

```bash
ln -sf "$(pwd)/opencode/AGENTS.md" "$(pwd)/opencode/workflow-agents.md" "$(pwd)/opencode/testing-agents.md" "$(pwd)/opencode/opencode.jsonc" ~/.config/opencode/
for d in opencode/skills/*/; do
  name=$(basename "$d")
  mkdir -p ~/.config/opencode/skills/"$name"
  ln -sf "$(pwd)/$d/SKILL.md" ~/.config/opencode/skills/"$name"/
done
ln -sf "$(pwd)/cursor/"*.mdc ~/.cursor/rules/
```

**Note:** Edit `opencode.jsonc` `provider.dgx.options.baseURL` if your inference server is not `http://edgexpert-84c0:8080/v1`. Model IDs must match what your server reports at `/v1/models`.

## OpenCode load order

**Always-on (~7KB):**

1. `AGENTS.md` (auto-loaded)
2. `workflow-agents.md`
3. `testing-agents.md`

**On demand:** domain skills in `~/.config/opencode/skills/` — agent loads via `skill({ name: "backend" })` when task matches. See skill index in `AGENTS.md`.

Verify:

```bash
opencode debug config
wc -c ~/.config/opencode/AGENTS.md ~/.config/opencode/workflow-agents.md ~/.config/opencode/testing-agents.md
```

## Models (DGX Spark)

Default config in `opencode.jsonc`:

| Key | Model | Role |
|-----|-------|------|
| `model` | `dgx/ornith` | Primary agent work |
| `small_model` | `dgx/qwen3.6-27b` | Titles, lightweight tasks |
| (available) | `dgx/deepseek-v4-flash` | Switch via `/models` when deployed |

Local inference timeouts: 600s request, 120s chunk. Compaction pruning enabled to save context on long sessions.

## Cursor always-on vs globs

**Always apply:** `agent-workflow`, `ponytail`, `code-quality`, `testing`

**Glob-attached:** domain rules attach when you edit matching files (see frontmatter `globs` in each `.mdc`).

## Related

- Global dev index: `~/dev/AGENTS.md` (pointers to these paths; not duplicated here)
