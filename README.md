# agent-harness

Always-on agent rules and **OKF knowledge bundle** for **OpenCode**, **Cursor**, and **Hermes agent** — workflow, TDD, domain expertise, and supervised small-model execution (Qwen3.6-27B / Ornith on DGX via Tailscale).

## Layout

```
knowledge/              # OKF v0.1 bundle — practices, APIs, workflows, models
  index.md
  practices/ apis/ workflows/ models/

opencode/               # OpenCode config + skills
  opencode.jsonc
  planning-spec-driven.md
  skills/               # domain + knowledge-lookup, planner-packet, execute-spec

cursor/                 # Cursor .mdc rules

hermes/                 # Hermes agent target
  SOUL.md
  config.example.yaml
  skills/               # harvested devshop v1 + harness v2 skills

scripts/
  okf-lint.sh           # validate knowledge bundle

examples/
  e2e-sample-task-packet.md

install.sh              # --target opencode|cursor|hermes|all
```

## Install

```bash
# Mac: OpenCode + Cursor
./install.sh --link

# Deploy Hermes skills to VPS (git pull + install on hetzner-vps)
./install.sh --target hermes

# All local targets
./install.sh --link --target all
```

VPS pattern: clone at `~/dev/agent-harness`, `git pull`, `./install.sh --target hermes`.

## Harness v2 (supervised loop)

1. **Planner** (Opus/Cursor): `planner-packet` skill → `.harness/task-packet.md`
2. **Executor** (Qwen/Ornith): `execute-spec` — one AC per session, fail-stop, human gate
3. **Knowledge**: `knowledge-lookup` skill — progressive disclosure, no vector RAG required
4. **Fail-stop**: no auto-retry; user says `resume` or `retry`

See [knowledge/workflows/agentic-loop-supervised.md](knowledge/workflows/agentic-loop-supervised.md) and [devshop v1 postmortem](knowledge/workflows/devshop-v1-learnings.md).

## Models

| Target | Model | Endpoint |
|--------|-------|----------|
| OpenCode (Mac) | `dgx/qwen3.6-27b` | `http://edgexpert-84c0:8080/v1` |
| Hermes (VPS) | `qwen3.6-27b` | DGX Tailscale (see hermes/config.example.yaml) |

## Verify

```bash
./scripts/okf-lint.sh
opencode debug config   # after install
```

## Related repos

- [spark_ops](https://github.com/dpav02/spark_ops) — DGX serve scripts, VPS `~/spark/` deploy source
- Project repos: polymarket-trader, sol-wallet-scanner, jobpriced, tattoo_video_removal
